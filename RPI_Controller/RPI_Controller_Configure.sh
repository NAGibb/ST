#!/bin/sh

# check root status
if [ "$(id -u)" != "0" ]; then
   echo "Configuration script must be run as root. Try again." 1>&2
   exit 1
fi

rpi_cron_file="/ST/RPI_Controller/cronScheduler.sh"

if [ -f $rpi_cron_file ];
then
   echo "File $rpi_cron_file exists."
else
   echo "File $rpi_cron_file does not exist."
fi
