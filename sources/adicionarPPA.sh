#!/usr/bin/env bash
adicionarPPA() {
	# Remove palavras indesejadas
	ppaAtual=$(echo $1 | sed -e "s/\/ppa//g" -e "s/\/stable//g" -e "s/\-stable//g")
	# Verifica se o ppa esta subdividido por /
	if [[ "${ppaAtual}" =~ "/" ]]; then
		# Separa a subdivisao em dois parametros
		ppaAtual=$(echo $ppaAtual | sed -n 's/\(.*\)\/\(.*\)/\1.*\2/p')
	fi

	ppaInstalado=$(find /etc/apt/sources.list.d/ -type f -regextype posix-extended -regex ".*$ppaAtual.*.list$")
	[ -z "${ppaInstalado}" ] && sudo apt-add-repository -y ppa:${1}
}
