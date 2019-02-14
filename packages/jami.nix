{ fetchurl, in-debian-chroot, mkBin }:

with rec {
  pkg = fetchurl {
    url    = "https://dl.ring.cx/ring-manual/ubuntu_18.10/ring-all_i386.deb";
    sha256 = "1wpnhkg60sh3j24f0qvvs0x4m6jrljlxrcamarrvv6nzigylk10d";
  };

  rootRepo    = "tianon/docker-brew-ubuntu-core";
  rootVersion = "7299dc6e6ed2496ee9d1b4741c4822927bfdabe3/cosmic";
  rootFile    = "ubuntu-cosmic-core-cloudimg-i386-root.tar.gz?raw=true";
  rootfs      = fetchurl {
    url    = "https://github.com/${rootRepo}/blob/${rootVersion}/${rootFile}";
    sha256 = "07741p4wn2ar1pbim1w7d4lz3bcak7pafnldldgb1igvs3aiqksg";
  };
};
mkBin {
  name = "jami";
  vars = {
    runner = in-debian-chroot {
      inherit rootfs;
      post = "apt-get clean";
      pre  = ''
        # Force nameserver since default is blank
        echo "nameserver 8.8.8.8" > /etc/resolv.conf

        # Avoid PAM errors from systemd (urgh)
        ln -s -f /bin/true /usr/bin/chfn
      '';
      debs = [ pkg ];
      pkgs = [
        "dconf-gsettings-backend"
        "gnome-icon-theme"
        "gnupg"
        "hicolor-icon-theme"
        "libargon2-1"
        "libasound2"
        "libavcodec58"
        "libavdevice58"
        "libavfilter7"
        "libavformat58"
        "libavutil56"
        "libayatana-appindicator3-1"
        "libcairo2"
        "libcanberra-gtk3-0"
        "libcanberra0"
        "libclutter-1.0-0"
        "libclutter-gtk-1.0-0"
        "libdbus-1-3"
        "libgdk-pixbuf2.0-0"
        "libglib2.0-0"
        "libgtk-3-0"
        "libhogweed4"
        "libjsoncpp1"
        "libnatpmp1"
        "libnettle6"
        "libnm0"
        "libnotify4"
        "libpango-1.0-0"
        "libpng16-16"
        "libpulse0"
        "libqrencode3"
        "libqt5core5a"
        "libqt5dbus5"
        "libqt5gui5"
        "libqt5sql5"
        "libssl1.1"
        "libswresample3"
        "libswscale5"
        "libwebkit2gtk-4.0-37"
        "libx11-6"
        "libqt5sql5-sqlite"
      ];
    };
  };
  script = ''
    #!/usr/bin/env bash
    "$runner" gnome-ring
  '';
}
