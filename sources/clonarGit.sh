#!/usr/bin/env bash
clonarGit() {
	echo "-> Informe a URL do projeto a ser clonado."
	read projGit

	if [ -z "${projGit}" ]; then
		echo "-> URL do projeto vazia. Deseja reinserí-la? (S/n)"
		read decisao

		if [ -z "${decisao}" ] || [ "${decisao,,}" == "s" ]; then
			echo "-> Informe a URL do projeto a ser clonado."
			read projGit

			[ -z "${projGit}" ] && clonarGit
		else
			echo "--> Deseja voltar ao menu anterior ou sair? (S=sim/n=sair)"
			read opcao

			if [ -z "${opcao}" ] || [ "${opcao,,}" == "s" ]; then
				projetos
			else
				exit
			fi
		fi
	fi

	cd $HOME/Projetos
	git clone ${projGit}
	cd ~/
}
