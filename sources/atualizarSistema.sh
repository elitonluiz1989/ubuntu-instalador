#!/usr/bin/env bash
atualizarSistema() {
	echo "--> Atualizando o sistema."

	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -y
	sudo apt-get autoclean -y
	sudo apt-get autoremove -y
}
