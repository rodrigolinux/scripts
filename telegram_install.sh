#!/bin/bash
#
######################################################
# Autor:     Rodrigo Costa                           #
# Contato:   rodrigo.costa@outlook.it                #
# Link:      https://github.com/rodrigolinux         #
# Data:      14/02/2022                              #
# Licença:   GPLv3                                   #
# Sobre:     Instala o mensageiro Telegram           #
# Obs:       Testado no Debian 11 Bullseye           #
######################################################
#
if [[ $EUID -ne 0 ]]; then
	echo "Deve ser executado como root."
	echo "ex: sudo ./telegram_install.sh"
	exit 1
fi
#
echo
echo $'-----------------------------------\nInstalando o mensageiro Telegram...'
echo '-----------------------------------'
echo 'deb http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main \n
deb-src http://ppa.launchpad.net/atareao/telegram/ubuntu xenial main' > /etc/apt/sources.list.d/telegram.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6A9653F936FD5529
apt update && apt install telegram
echo $'---------------------\nInstalação concluída!'
echo '---------------------'
sleep 3
echo
