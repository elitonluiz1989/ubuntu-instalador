#!/usr/bin/env bash
instalarPrograma() {
	if [ "$1" != "semPPA" ]; then
		echo "--> Instalar progrma com PPA? (s/N)"
		read comPPA

		if [ "${comPPA,,}" == "s" ]; then
			echo "Informe o PPA:"
			read ppa

			ppa=$(echo $ppa | sed -n 's/\(.*\):\(.*\)/\2/p')

			[ ! -z "${ppa}" ] && adicionarPPA $ppa

			sudo apt-get update
		fi
	fi

	echo "--> Informe o nome do programa:"
	read programa

	if [ -z "${programa}" ]; then
		echo "--> Erro: programa não informado!"
		echo "-> Deseja redigitar? S/n"
		read reiniciar

		reiniciar=$(echo $reiniciar || sed -e 's/\(.\)/\L\1/')
		if [ -z "${reiniciar}" ] || [ "${reiniciar,,}" == "s" ]; then
			instalarPrograma "semPPA"
		else
			echo "--> Deseja voltar para o menu inicial? (S=sim/N=sair)"
			read opcao

			opcao=$(echo $opcao | sed -e 's/\(.\)/\L\1/')
			if [ -z "${opcao}" ] || [ "${opcao,,}" == "s" ]; then
				menu
			else
				echo "---> Até mais!"
				exit;
			fi
		fi
	else
		sudo apt-get install -y ${programa}
	fi
}
