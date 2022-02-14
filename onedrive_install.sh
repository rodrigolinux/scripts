#!/bin/bash
#
######################################################
# Autor:     Rodrigo Costa                           #
# Contato:   rodrigo.costa@outlook.it                #
# Link:      https://github.com/rodrigolinux         #
# Data:      14/02/2022                              #
# Licença:   GPLv3                                   #
# Sobre:     Instala o Microsoft OneDrive            #
# Obs:       Testado no Debian 11 Bullseye           #
######################################################
#
if [[ $EUID -ne 0 ]]; then
	echo "Deve ser executado como root."
	echo "ex: sudo ./onedrive_install.sh"
	exit 1
fi
#
echo
echo $'---------------------------------\nInstalando o OneDrive...'
echo '---------------------------------'
add-apt-repository ppa:yann1ck/onedrive
mv /etc/apt/sources.list.d/yann1ck-ubuntu-onedrive-{jammy,focal}.list
sed -i 's/jammy/focal/g'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0512B5FE7F557AB1
apt update
# https://packages.debian.org/sid/amd64/onedrive/download
wget -P /tmp http://downloads.dlang.org/releases/2.x/2.093.1/dmd_2.093.1-0_amd64.deb
dpkg -i /tmp/dmd_2.093.1-0_amd64.deb
apt install libcurl4-openssl-dev
cd /tmp
git clone https://github.com/abraunegg/onedrive.git
cd onedrive && ./configure
apt install onedrive
onedrive
# Visit the URI you received once you run the above command.
# This URI will give you the response URI that you need to paste into the prompt. It will authenticate you to OneDrive.
# Synchronize the Package Using the Below Command. Will create ~/OneDrive folder
# onedrive --synchronize --verbose --dry-run
onedrive --synchronize
# Finally, install “Isync,” Which Connects Your System and OneDrive
onedrive --monitor
echo
echo $'---------------------\nInstalação concluída!'
echo '---------------------'
sleep 3
echo
