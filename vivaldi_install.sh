#!/bin/bash
#
######################################################
# Autor:     Rodrigo Costa                           #
# Contato:   rodrigo.costa@outlook.it                #
# Link:      https://github.com/rodrigolinux         #
# Data:      06/02/2022                              #
# Licença:   GPLv3                                   #
# Sobre:     Instala o navegador Vivaldi             #
# Obs:       Testado no Debian 11 Bullseye           #
######################################################
#
if [[ $EUID -ne 0 ]]; then
	echo "Deve ser executado como root."
	echo "ex: sudo ./vivaldi_install.sh"
	exit 1
fi
#
echo
echo $'---------------------------------\nInstalando o navegador Vivaldi...'
echo '---------------------------------'
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
apt update && apt install vivaldi-stable -y
echo $'---------------------\nInstalação concluída!'
echo '---------------------'
sleep 3
echo
