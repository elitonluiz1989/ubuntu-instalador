#!/usr/bin/env bash
definirServername() {
	[ ! -z "${1}" ] && (servername=$1; exit 1)
	if [ -z "${servername}" ]; then
		echo "O servername informado está em branco. Reinsira-o por favor."
		read servername

		definirServername $servername
	else	
		verificarHost=$(grep "${servername}" "/etc/hosts")
		if [ ! -z "${verificarHost}" ]; then
			echo "O servername que utilizou já está definido no arquivo hosts. Deseja inserir outro?(S/n)"
			read decisao

			if [ -z "${decisao}" ] || [ "${decisao,,}" == "s" ]; then
				echo "Digite o novo servername:"
				read servername

				definirServername $servername
			fi
		else
			echo -e "\n127.0.1.1\t${servername}\twww.${servername}" | sudo tee -a /etc/hosts
		fi
	fi
}

adicionarVirtualhost() {
	dir_projeto="${HOME}/Projetos/Web/${1}"
	virtualhost=/etc/apache2/sites-available/${1}.conf

	if [ -f "${virtualhost}" ]; then
		echo "--> Já existe um arquivo conf com o nome do projeto."
		echo "--> Deseja editá-lo? (S/n)"
		read decisao

		[ -z "${decisao}" ] || [ "${decisao,,}" == "s" ] && (sudo nano $virtualhost; exit 1)
	else
		servername="${1}.dev"
		docroot=""
		logDir="logs"

		echo "Deseja definir o severname do projeto?(s/N)"
		read decisao
		[ "${decisao,,}" == "s" ] && {
			echo "Digite o servername."
			read servername
		}
		definirServername
		
		echo "Deseja definir o Document Root do projeto (Ex.: public)?(s/N)"
		read decisao
		[ "${decisao,,}" == "s" ] && {
			echo "Digite o docroot."
			read docroot
			
			[ "${docroot}" != "${dir_projeto}" ] && {
				docroot="${dir_projeto}/${docroot}"
				mkdir -v "${docroot}"
				sudo chmod -R 775 "${docroot}"
			}
		}
		

		echo "Deseja definir o diretório de logs (Ex.: storage/logs)?(s/N)"
		read decisao
		[ "${decisao,,}" == "s" ] && {
			echo "Digite o diretório de logs"
			read logDir
		}

		[ ! -d "${dir_projeto}/$logDir" ] && (mkdir -pv "${dir_projeto}/${logDir}"; exit 1 )

		sudo touch $virtualhost

		virtualhostConteudo+="<VirtualHost *:80>\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="	ServerName ${servername}\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="	ServerAlias www.${servername}\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="	DocumentRoot ${docroot}\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="	ErrorLog ${dir_projeto}/${logDir}/error.log\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="	<Directory ${docroot}>\n"
		virtualhostConteudo+="		\n"
		virtualhostConteudo+="		DirectoryIndex index.html index.php\n"
		virtualhostConteudo+="		\n"
		virtualhostConteudo+="		AllowOverride All\n"
		virtualhostConteudo+="		\n"
		virtualhostConteudo+="		Require all granted\n"
		virtualhostConteudo+="		\n"
		virtualhostConteudo+="	</Directory>\n"
		virtualhostConteudo+="	\n"
		virtualhostConteudo+="</VirtualHost>";

		echo -e "${virtualhostConteudo}" | sudo tee "${virtualhost}"
	fi

	# Verifica se o modulo rewrite esta habilitado
	[ -z $(find /etc/apache2/mods-enabled/ -regextype posix-extended -regex ".*rewrite.*") ] && {
		sudo a2enmod rewrite
		sudo service apache2 restart
	}

	if [ -z $(find /etc/apache2/sites-enabled/ -regextype posix-extended -regex ".*${1}.*") ]; then
		sudo a2ensite ${1}.conf

		sudo service apache2 restart

		echo "VirtualHost adicionado!"
	else
		echo "VirtualHost já adicionado!"
	fi
}
