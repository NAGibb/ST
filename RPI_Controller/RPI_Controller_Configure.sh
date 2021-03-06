#!/bin/sh
#
# Set variables
rpi_Controller_Config="/ST/RPI_Controller/rpi_Controller_Config.cfg"
#
# wipe the screen
clear
#
# check root status stop here if not root
if [ "$(id -u)" != "0" ]; then
   echo "Configuration script must be run as root. Try again." 1>&2
   exit 1
fi
#
# Checking and Installing prerequisites
#
echo "Checking / Installing prerequisites...."
reqpackages="dialog"
for package in $reqpackages
do
  if ! which $package > /dev/null; then
    echo "Installing $package"
    apt-get -y install $package > /dev/null
  else
    echo "$package already installed"
  fi
done
#
# add check for prerequisites after install if they aren't there then exit
#
# Checking for configuration files
#
if [ -f "$rpi_Controller_Config" ];then
  #dialog --infobox "Reading existing configuration file" 10 30 ; sleep 20
  #for i in $(seq 0 10 100) ; do sleep 1; clear; echo $i | dialog --gauge "Reading existing configuration file" 10 70 0; done
  echo "not here"
   #echo "File $rpi_Controller_Config exists."
else
  #dialog --infobox "Reading existing configuration file" 10 30 ; sleep 20
   #echo "File $rpi_Controller_Config does not exist."
   dialog --infobox "No configuration file found.\nCreating default configuration file" 5 40 ; sleep 2
   #for i in $(seq 0 10 100) ; do sleep 1; clear; echo $i | dialog --gauge "No configuration file found" 10 70 0; done
   echo 10 | dialog --title "Installing scripts" --gauge "Creating directory /ST" 10 70 0;sleep 1;clear
   if [ ! -d "/ST" ];then
     mkdir "/ST"
   fi
   echo 20 | dialog --title "Installing scripts" --gauge "Cloning ST github repo" 10 70 0;sleep 1;clear
   if [ ! -d "/ST/.git" ];then
      git clone https://github.com/NAGibb/ST /ST
   else
     git clone https://github.com/NAGibb/ST /ST
   fi


   echo 30 | dialog --title "Installing scripts" --gauge "Reading existing configuration file" 10 70 0;sleep 1;clear

   #  create /ST
   #  create /ST/RPI_Controller
   #  create default rpi_Controller_Config.cfg config file

fi




# clean up the screen after we are done
clear
