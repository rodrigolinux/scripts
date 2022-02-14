#!/bin/bash
#
##########################################################################
# Autor:     Rodrigo Costa                           			 #
# Contato:   rodrigo.costa@outlook.it                			 #
# Link:      https://github.com/rodrigolinux/teams_install               #
# Data:      06/02/2022                              			 #
# Licença:   GPLv3                                   			 #
# Arquivo:   teams_install.sh	    				         #
# Sobre:     Script que ao ser executado exibe uma janela (em Dialog)    #
#            solicitando qual plataforma (DEB ou RPM) deseja instalar    #
##########################################################################
#
if [[ $EUID -ne 0 ]]; then
   echo "Deve ser executado como root." 
   echo "ex: sudo ./teams_install.sh"
   exit 1
fi
#
# Necessario ter instalado o pacote dialog
apt install dialog -y
#
HEIGHT=10
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Instalador"
TITLE="Microsoft Teams"
MENU="Escolha de acordo com seu sistema: "

OPTIONS=(1 "Pacote .deb"
         2 "Pacote .rpm")

OPT=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $OPT in
        1)
            echo "Instalando .deb"
            		curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
			echo 'deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main' > /etc/apt/sources.list.d/teams.list
			apt update && apt install teams -y
            ;;
        2)
            echo "Instalando .rpm"
            		rpm --import https://packages.microsoft.com/keys/microsoft.asc
			echo -e '[teams]\nname=teams\nbaseurl=https://packages.microsoft.com/yumrepos/ms-teams\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc' > /etc/yum.repos.d/teams.repo
			dnf check-update
			dnf install teams -y
			dnf install microsoft-edge-dev -y
            ;;
esac
