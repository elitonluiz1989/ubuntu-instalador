#!/usr/bin/env bash
sudo wget -nv https://download.owncloud.org/download/repositories/stable/xUbuntu_15.10/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo rm -v Release.key
sudo sh -c "echo 'deb http://download.owncloud.org/download/repositories/stable/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/owncloud.list"
