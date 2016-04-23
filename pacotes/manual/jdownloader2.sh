#!/usr/bin/env bash
if [ ! -d "${HOME}/jd2" ]; then
    wget http://installer.jdownloader.org/JD2SilentSetup_x64.sh
    sudo chmod +x JD2SilentSetup*.sh
    ./JD2SilentSetup*.sh
    rm JD2SilentSetup*.sh
else
    echo "jdownloader2 já é a versão mais nova."
fi
