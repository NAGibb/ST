#!/bin/sh


# Set variables
croninterval="unknown"
cronaction="unknown"
crondevice="unknown"
croncommand="unknown"
cronstatusreturn="unknown"
cronoutput="unknown"
#
# get script options and set variables
while [ $# -gt 1 ]
do
  key="$1"
  case $key in
    -i|--interval)
      case $2 in
        quarter)
            croninterval="quarter"
        ;;
        half)
            croninterval="half"
        ;;
        full)
            croninterval="full"
        ;;
        day)
            croninterval="day"
        ;;
        *)
            croninterval="unknown"
        ;;
      esac
      shift
      ;;
    -a|--action)
      case $2 in
        add)
          cronaction="add"
        ;;
        delete)
          cronaction="delete"
        ;;
        print)
          cronaction="print"
        ;;
        *)
          cronaction="unknown"
        ;;

      esac
    shift
    ;;
    -d|--device)
      crondevice="$2"
      shift
    ;;
    -c|--command)
      case $2 in
        ping)
          croncommand="ping"
        ;;
        http)
          croncommand="http"
        ;;
        *)
          croncommand="unknown"
        ;;
      esac
    shift
    ;;
    -s|--status)
      case $2 in
        msg)
          cronstatusreturn="msg"
        ;;
        onoff)
          cronstatusreturn="onoff"
        ;;
        status)
          cronstatusreturn="status"
        ;;
        *)
          croncommand="unknown"
        ;;
      esac
    shift
    ;;
    -o|--output)
      cronoutput="${2}"
      shift
    ;;

# functions needed
# ping / up
  esac
  shift # past argument or value
done




echo interval  = "${croninterval}"
echo action     = "${cronaction}"
echo device     = "${crondevice}"
echo command    = "${croncommand}"
echo statusreturn = "${cronstatusreturn}"
echo output     =   "${cronoutput}"



#echo LIBRARY PATH    = "${LIBPATH}"
#echo "Number files in SEARCH PATH with EXTENSION:" $(ls -1 "${SEARCHPATH}"/*."${EXTENSION}" | wc -l)
#if [[ -n $1 ]]; then
#    echo "Last line of file specified as non-opt/last argument:"
#    tail -1 $1
#fi



# get command line options

# figure out which option is needed

# configure variables based on type

# options
# add / delete


#quarterpidfile=/var/run/RPI_Controller_quarter.pid
#halfpidfile=/var/run/RPI_Controller_half.pid
#fullpidfile=/var/run/RPI_Controller_full.pid
#daypidfile=/var/run/RPI_Controller_day.pid

# Ensure PID file is removed on program exit.
#trap "rm -f -- '$mypidfile'" EXIT

# Create a file with current PID to indicate that process is running.
#echo $$ > "$mypidfile"
