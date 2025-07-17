#include <QApplication>
#include <QLibrary>
#include <QDir>
#include <QDebug>
#include <QWidget>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QStandardPaths>
#include <QProcessEnvironment>
#include <QMetaObject>
#include <QMetaMethod>
#include <QTimer>
#include <dlfcn.h>

class ConfigPersistenceWrapper : public QWidget {
    Q_OBJECT

public:
    ConfigPersistenceWrapper(QWidget* configWidget, QWidget* parent = nullptr)
        : QWidget(parent), m_configWidget(configWidget) {

        setWindowTitle("Skulpture Configuration");

        QVBoxLayout* layout = new QVBoxLayout(this);
        layout->addWidget(configWidget);

        // Control buttons
        QHBoxLayout* buttonLayout = new QHBoxLayout;

        QPushButton* applyBtn = new QPushButton("Apply");
        QPushButton* saveBtn = new QPushButton("Save");
        QPushButton* resetBtn = new QPushButton("Reset");
        QPushButton* closeBtn = new QPushButton("Close");

        buttonLayout->addWidget(applyBtn);
        buttonLayout->addWidget(saveBtn);
        buttonLayout->addWidget(resetBtn);
        buttonLayout->addStretch();
        buttonLayout->addWidget(closeBtn);

        layout->addLayout(buttonLayout);

        // Connect persistence operations
        connect(applyBtn, &QPushButton::clicked, this, &ConfigPersistenceWrapper::applyConfig);
        connect(saveBtn, &QPushButton::clicked, this, &ConfigPersistenceWrapper::saveConfig);
        connect(resetBtn, &QPushButton::clicked, this, &ConfigPersistenceWrapper::resetConfig);
        connect(closeBtn, &QPushButton::clicked, this, &QWidget::close);

        // Monitor config widget for changes
        if (m_configWidget) {
            m_configWidget->installEventFilter(this);
            findAndConnectSignals();
        }
    }

private slots:
    void applyConfig() {
        if (!m_configWidget) return;

        // Invoke standard KConfigModule methods
        const QMetaObject* metaObj = m_configWidget->metaObject();

        // Try load() method
        for (int i = 0; i < metaObj->methodCount(); ++i) {
            QMetaMethod method = metaObj->method(i);
            if (method.name() == "load") {
                method.invoke(m_configWidget);
                break;
            }
        }

        // Try save() method
        for (int i = 0; i < metaObj->methodCount(); ++i) {
            QMetaMethod method = metaObj->method(i);
            if (method.name() == "save") {
                method.invoke(m_configWidget);
                break;
            }
        }

        qDebug() << "Applied configuration";
    }

    void saveConfig() {
        applyConfig();

        // Force KConfig sync
        if (m_configWidget) {
            const QMetaObject* metaObj = m_configWidget->metaObject();
            for (int i = 0; i < metaObj->methodCount(); ++i) {
                QMetaMethod method = metaObj->method(i);
                if (method.name() == "defaults") {
                    // Skip defaults, look for sync-related methods
                    continue;
                }
                if (method.name().contains("sync") || method.name().contains("write")) {
                    method.invoke(m_configWidget);
                }
            }
        }

        qDebug() << "Saved configuration";
    }

    void resetConfig() {
        if (!m_configWidget) return;

        const QMetaObject* metaObj = m_configWidget->metaObject();
        for (int i = 0; i < metaObj->methodCount(); ++i) {
            QMetaMethod method = metaObj->method(i);
            if (method.name() == "defaults") {
                method.invoke(m_configWidget);
                break;
            }
        }

        qDebug() << "Reset to defaults";
    }

private:
    void findAndConnectSignals() {
        if (!m_configWidget) return;

        const QMetaObject* metaObj = m_configWidget->metaObject();

        // Look for changed() signal
        for (int i = 0; i < metaObj->methodCount(); ++i) {
            QMetaMethod method = metaObj->method(i);
            if (method.methodType() == QMetaMethod::Signal &&
                method.name() == "changed") {
                // Connect to our change handler
                connect(m_configWidget, SIGNAL(changed(bool)),
                        this, SLOT(configChanged(bool)));
                break;
            }
        }
    }

private slots:
    void configChanged(bool changed) {
        qDebug() << "Configuration changed:" << changed;
        // Could enable/disable apply button based on changed state
    }

private:
    QWidget* m_configWidget;
};

int main(int argc, char *argv[]) {
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();

    QString skulptureDataPath = "${skulpture-package}/share";
    QString existingDataDirs = env.value("XDG_DATA_DIRS", "/usr/share:/usr/local/share");
    QString newDataDirs = skulptureDataPath + ":" + existingDataDirs;
    qputenv("XDG_DATA_DIRS", newDataDirs.toLocal8Bit());

    qputenv("KDEDIRS", "${skulpture-package}");
    qputenv("KDE_SESSION_VERSION", "5");

    QApplication app(argc, argv);
    app.setApplicationName("skulpture");
    app.setOrganizationName("skulpture");

    QString pluginPath = "${skulpture-package}/lib/qt-5.15.16/plugins/kstyle_skulpture_config.so";

    void* handle = dlopen(pluginPath.toLocal8Bit().data(), RTLD_LAZY);
    if (!handle) {
        qDebug() << "dlopen failed:" << dlerror();
        return 1;
    }

    typedef QWidget* (*ConfigWidgetFactory)();
    ConfigWidgetFactory factory = (ConfigWidgetFactory)dlsym(handle, "allocate_kstyle_config");

    if (!factory) {
        qDebug() << "Factory symbol not found";
        dlclose(handle);
        return 1;
    }

    QWidget* configWidget = nullptr;
    try {
        configWidget = factory();
    } catch (const std::exception& e) {
        qDebug() << "Factory exception:" << e.what();
        dlclose(handle);
        return 1;
    } catch (...) {
        qDebug() << "Unknown factory exception";
        dlclose(handle);
        return 1;
    }

    if (!configWidget) {
        qDebug() << "Factory returned null widget";
        dlclose(handle);
        return 1;
    }

    ConfigPersistenceWrapper* wrapper = new ConfigPersistenceWrapper(configWidget);
    wrapper->show();

    int result = app.exec();

    delete wrapper;
    dlclose(handle);

    return result;
}

#include "main.moc"
