#!/bin/bash
echo "Deixando programa executável."
sudo chmod +x -v ./ubuntu-instalador

if [ ! -d "$HOME/bin" ] ; then
  echo "Criando a pasta \"bin\" na pasta do usuário"
  mkdir "$HOME/bin"
fi

echo "Adicinando o programa a pasta \"bin.\""
sudo ln -s -v ./ubuntu-instalador "$HOME/bin/"
exit;
