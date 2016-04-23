#!/usr/bin/env bash
criarProjeto() {
	
	echo "---> Defina o nome do projeto:"
	read projeto

	if [ -z "${projeto}" ]; then
		echo "---> Nome do projeto está vazio."
		echo "---> Deseja reinserí-lo? (S/n)"
		read reiniciar

		if [ -z "${reiniciar}" ] || [ "${reiniciar,,}" == "s" ]; then
			criarProjetos
		else
			echo "--> Deseja voltar ao menu inicial ou sair? (S=sim/n=sair)"
			read opcao

			if [ -z "${opcao}" ] || [ "${opcao,,}" == "s" ]; then
				menu
			else
				exit
			fi
		fi
	else
		projeto="${projeto,,}"
	
		dir_projeto=${dir_projetos}/${projeto}

		if [ -d "${dir_projeto}" ]; then
			echo "--> A pasta do projeto ${projeto} já existe."
			echo "--> Talvez o projeto já tenha sido criado."
			echo "--> Deseja continuar? (S/n)"
			read decisao

			[ -z "${decisao}" ] || [ "${decisao,,}" == "s" ] || exit
		else
			mkdir -pv $dir_projeto
		fi

		echo "--> Deseja criar um VirtualHost? (S/n)";
		read decisao

		[ -z "${decisao}" ] || [ "${decisao,,}" == "s" ] && adicionarVirtualhost $projeto

		echo "--> Deseja iniciar versionamento com GIT? (S/n)"
		read decisao
		[ -z "${decisao}" ] || [ "${decisao,,}" == "s" ] && iniciarGit $projeto
	fi
}
