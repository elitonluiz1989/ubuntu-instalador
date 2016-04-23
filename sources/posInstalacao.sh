#!/usr/bin/env bash
buscarInstrucoes() {
	# Busca instrucoes a partir de um expressao e substui caractes para facilitar
	# a convercao do resultado em ARRAY
	arqs=$(find $FOLDER/pacotes/$1/ -type f)
	arqs=$( echo $arqs | sed -e 's/ /;/g')

	# Cria um ARRAY com as listas de pacotes
	instrucoes=(${arqs//;/ })
}

instalacaoPadrao() {
	buscarInstrucoes "padrao"

	for instrucao in "${instrucoes[@]}"; do
		if [ -f $instrucao ]; then
			titulo=$(echo $instrucao | sed -e 's/.*\///')
			echo "------ ${titulo^} ------"

			# Cria um string com as linhas do arquivo
			pacotes=$(cat $instrucao)
			sudo apt-get install -y $pacotes
		fi
	done
}

executarInstrucaoManual() {
	instrucao=${1}
	nomePacote=$(echo $instrucao | sed -e 's/.*\///')
	nomePacote=$(echo $nomePacote | sed 's/.sh//')
	pacoteInstalado=$(which $nomePacote 2>/dev/null | grep -v "not found" | wc -l)

	if [ "$pacoteInstalado" -eq 0 ]; then
		bash "${instrucao}"
	else
		echo "${nomePacote} já é a versão mais nova."
	fi
}

instalacaoManual() {
	buscarInstrucoes "manual"

	for instrucaoManual in "${instrucoes[@]}"; do
		executarInstrucaoManual $instrucaoManual
	done
}

posInstalacao() {
	# Adiciona PPAs necessarios
	gerenciadorPPA

	# Depois de verificado os PPAs atualiza o sistema
	atualizarSistema

	echo "--> Instalando os pacotes."
	# Instalacao padrao
	instalacaoPadrao

	# Instalando os pacotes manualmente
	instalacaoManual

	echo "--> Removendo o lixo."
	sudo apt-get autoclean -y
	sudo apt-get autoremove -y
	echo "---------------------"
	echo "--> Terminado!"
}
