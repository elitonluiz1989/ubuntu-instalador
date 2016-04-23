#!/usr/bin/env bash
gitRepositorio() {
	echo "--> Informe a URL do repositório."
	read repo

	if [ -z "${repo}" ]; then
		echo "-> URL está vazia. Deseja reinserí-la? (S/n)"
		read decisao

		if [ -z "${decisao}" ] || [ "${decisao,,}" == "s" ]; then
			gitRepositorio
		else
			exit
		fi
	fi

	cd ${1}
	git remote add origin ${repo}
}
