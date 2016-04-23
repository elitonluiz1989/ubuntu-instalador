#!/usr/bin/env bash
if [ ! -d "/usr/share/themes/Arc" ]; then
    sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}
    wget http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_15.10/all/arc-theme_1459454111.c561afa_all.deb
    sudo dpkg -i arc-theme_1459454111.c561afa_all.deb
    rm -v arc-theme_1459454111.c561afa_all.deb
else
    echo "arc-theme já é a versão mais nova."
fi
