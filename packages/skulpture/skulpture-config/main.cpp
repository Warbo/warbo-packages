#include <QApplication>
#include <QLibrary>
#include <QDir>
#include <QDebug>
#include <QWidget>
#include <QVBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QStandardPaths>
#include <QProcessEnvironment>
#include <dlfcn.h>

int main(int argc, char *argv[]) {
    // Set up KDE environment before QApplication
    QProcessEnvironment env = QProcessEnvironment::systemEnvironment();

    // Configure XDG data directories for KDE resource resolution
    QString skulptureDataPath = "${skulpture-package}/share";
    QString existingDataDirs = env.value("XDG_DATA_DIRS", "/usr/share:/usr/local/share");
    QString newDataDirs = skulptureDataPath + ":" + existingDataDirs;
    qputenv("XDG_DATA_DIRS", newDataDirs.toLocal8Bit());

    // Set KDE-specific paths
    qputenv("KDEDIRS", "${skulpture-package}");
    qputenv("KDE_SESSION_VERSION", "5");

    QApplication app(argc, argv);

    // Set application domain for i18n
    app.setApplicationName("skulpture");
    app.setOrganizationName("skulpture");

    QString pluginPath = "${skulpture-package}/lib/qt-5.15.16/plugins/kstyle_skulpture_config.so";

    void* handle = dlopen(pluginPath.toLocal8Bit().data(), RTLD_LAZY);
    if (!handle) {
        qDebug() << "dlopen failed:" << dlerror();
        return 1;
    }

    // Resolve factory function
    typedef QWidget* (*ConfigWidgetFactory)();
    ConfigWidgetFactory factory = (ConfigWidgetFactory)dlsym(handle, "allocate_kstyle_config");

    if (!factory) {
        qDebug() << "Factory symbol not found";
        dlclose(handle);
        return 1;
    }

    // Create widget with exception handling
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

    // Basic widget validation
    if (!configWidget->isVisible() && configWidget->size().isEmpty()) {
        qDebug() << "Widget appears invalid (empty size)";
        delete configWidget;
        dlclose(handle);
        return 1;
    }

    configWidget->setWindowTitle("Skulpture Configuration");
    configWidget->show();

    int result = app.exec();

    // Clean shutdown
    delete configWidget;
    dlclose(handle);

    return result;
}
