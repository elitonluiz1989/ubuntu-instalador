#!/usr/bin/env bash
buscarPPAsManuais() {
	# Busca PPAs a partir de um expressao e substui caractes para facilitar
	# a convercao do resultado em ARRAY
	arqs=$(find $FOLDER/ppas/manual/ -type f)
	arqs=$( echo $arqs | sed -e 's/ /;/g')

	# Cria um ARRAY com as listas de PPAs
	ppasManuais=(${arqs//;/ })
}

gerenciadorPPA() {
    # Pega lista de PPAs contida no arquivo ppas
    mapfile ppas < $FOLDER/ppas/lista

    # Verificando se ha necessidade de instala-los
    echo "------ PPAs ------"
    echo "--> Verificando PPAs."
    for ppa in "${ppas[@]}"; do
        nomePPA=$(echo $ppa | sed -e 's/.*=//')
        ppaExiste=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $nomePPA)

        if [ -z "${ppaExiste}" ]; then
            adicionarPPA "${ppa}"
        else
            echo "-->${nomePPA} já adicionado."
        fi
    done

    buscarPPAsManuais
    for ppaManual in "${ppasManuais[@]}"; do
        nomePPAManual=$(echo $ppaManual | sed -e 's/.*\///')
        nomePPAManual=$(echo $nomePPAManual | sed -e 's/.sh//')
        ppaExiste=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $nomePPAManual)

        if [ -z "${ppaExiste}" ]; then
            bash "${ppaManual}"
        else
            echo "-->${nomePPAManual} já adicionado."
        fi
    done
}
