#!/usr/bin/env bash
atualizarSistema() {
	echo "--> Atualizando o sistema."

	sudo apt update
	sudo apt upgrade -y
	sudo apt dist-upgrade -y
	sudo apt autoclean -y
	sudo apt autoremove -y
}
