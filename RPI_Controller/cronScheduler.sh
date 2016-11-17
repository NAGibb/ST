#!/bin/sh


quarterpidfile=/var/run/RPI_Controller_quarter.pid
halfpidfile=/var/run/RPI_Controller_half.pid
fullpidfile=/var/run/RPI_Controller_full.pid
daypidfile=/var/run/RPI_Controller_day.pid

# Ensure PID file is removed on program exit.
trap "rm -f -- '$mypidfile'" EXIT

# Create a file with current PID to indicate that process is running.
echo $$ > "$mypidfile"
