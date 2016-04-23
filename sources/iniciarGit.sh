#!/usr/bin/env bash
iniciarGit() {
	dir_projeto="${dir_projetos}/${1}"

	if [ -z "${1}" ] || [ ! -d ${dir_projeto} ]; then
		echo "--> Diretório não encontrado. Deseja redigitá-lo? (S/n)"
		read decisao

		if [ -z "$decisao" ] || [ "${decisao,,}" == "s" ]; then
			echo "--> Digite o nome da pasta do projeto."
			read dir_projeto

			if [ -z "${dir_projeto}" ] || [ ! -d "${dir_projetos}/${dir_projeto}" ]; then
				iniciarGit
			else
				dir_projeto="${dir_projetos}/${dir_projeto}"
			fi
		else
			echo "--> Deseja voltar ao menu inicial ou sair? (S=sim/n=sair)"
			read opcao

			if [ -z "${opcao}" ] || [ "${opcao,,}" == "s" ]; then
				projetos
			else
				exit
			fi
		fi
	fi

	# Entrando no diretorio do projeto
	cd ${dir_projeto}

	git init

	echo "--> Deseja adicionar um repositório remoto? (S/n)"
	read decisao

	[ -z "${decisao}" ] || [ "${decisao,,}" == "s" ] && gitRepositorio $dir_projeto

	echo "--> Versionamento iniciado."
	cd ~/
}
