#!/bin/sh


# Set variables
croninterval="unknown"
cronaction="unknown"
crondevice="unknown"
croncommand="unknown"
cronstatusreturn="unknown"
cronoutput="unknown"
cronopts=0
logfile="/var/log/cronscheduler.log"
#
#
# Functions
#
#
logger ()
{
# function options
# $1 level low to high {1-4}
# $2 msg
#
#
# set variablesloglevel=0

loglevel=""
logmessage=""

  # Check the log level
    case ${1} in
      1)
        loglevel="low"
      ;;
      2)
        loglevel="medium"
      ;;
      3)
        loglevel="high"
      ;;
      4)
        loglevel="security"
      ;;
      *)
        # first option is not a number. Set log level to low and use the input for the message so we dont lose anything important
        loglevel="low"
        logmessage="misconfigured log level - ${1} / ${2}"
      ;;
    esac

  # Check the message for special instructions
    case ${2} in
      -blank)
        logmessage=" "
        loglevel="supress"
      ;;
      -section)
        logmessage="_______________________________________________________________________________________________"
        loglevel="supress"
      ;;
      -header)
        logmessage="==============================================================================================="
        loglevel="supress"
      ;;
      *)
        logmessage=${2}
      ;;
    esac

    if [ $loglevel = "supress" ]; then
        # separators not level
        #echo `date +"%D %H:%M"` " ${logmessage}"
        echo `date +"%D %H:%M"` " ${logmessage}" >> $logfile
    else
        # normal output
        #echo `date +"%D %H:%M"` " - ${loglevel} - ${logmessage}"
        echo `date +"%D %H:%M"` " - ${loglevel} - ${logmessage}" >> $logfile
    fi

}

# check root status stop here if not root
if [ "$(id -u)" != "0" ]; then
   echo "Configuration script must be run as root. Try again." 1>&2
   exit 1
   logger 0 "-header"
   logger 4 "Configuration script must be run as root. Try again."
   logger 0 "-header"

fi
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
            # increment cronopts for a good option
            cronopts=$((cronopts+1))
        ;;
        half)
            croninterval="half"
            # increment cronopts for a good option
            cronopts=$((cronopts+1))
        ;;
        full)
            croninterval="full"
            # increment cronopts for a good option
            cronopts=$((cronopts+1))
        ;;
        day)
            croninterval="day"
            # increment cronopts for a good option
            cronopts=$((cronopts+1))
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
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        run)
          cronaction="run"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        delete)
          cronaction="delete"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        print)
          cronaction="print"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        *)
          cronaction="unknown"
        ;;

      esac
    shift
    ;;
    -d|--device)
      case $2 in
        "")
          crondevice="unknown"
        ;;
        -*)
          crondevice="unknown"
        ;;
        *)
        crondevice="${2}"
        # increment cronopts for a good option - here its any option
        cronopts=$((cronopts+1))
        ;;
      esac
      shift
    ;;
    -c|--command)
      case $2 in
        ping)
          croncommand="ping"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        http)
          croncommand="http"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        *)
          croncommand="unknown"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
      esac
    shift
    ;;
    -s|--status)
      case $2 in
        msg)
          cronstatusreturn="msg"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        onoff)
          cronstatusreturn="onoff"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        status)
          cronstatusreturn="status"
          # increment cronopts for a good option
          cronopts=$((cronopts+1))
        ;;
        *)
          croncommand="unknown"
        ;;
      esac
    shift
    ;;
    -o|--output)
      case $2 in
        "")
          cronoutput="unknown"
        ;;
        -*)
          cronoutput="unknown"
        ;;
        *)
        cronoutput="${2}"
        # increment cronopts for a good option - here its any option
        cronopts=$((cronopts+1))
        ;;
      esac
      shift
    ;;
  esac
  shift # past argument or value
done

  logger 0 "-header"
  logger 1 "Starting script"
  logger 0 "-header"
  logger 0 "-blank"
# check to see if we have all the information needed to execute

# check to see if this is just a simple run job
if [ ${croninterval} != "unknown" ] && [ ${cronaction} = "run" ]; then
  logger 1 "doing cron run"
  touch ${logfile}
# check to see if this is  complex action
else
  if [ ${cronopts} = 6 ];then
    echo "doing complex job"
  else
    echo "Incorrect number of options. Here are the options that have been detected."
    echo "Make sure that none of these options are showing unknown"
    echo "Number of good options: " ${cronopts}
    echo interval  = "${croninterval}"
    echo action     = "${cronaction}"
    echo device     = "${crondevice}"
    echo command    = "${croncommand}"
    echo statusreturn = "${cronstatusreturn}"
    echo output     =   "${cronoutput}"
  fi
fi






# functions needed
# ping / up
# logger
# when checking options for run only need interval and run options for all
# others its the full list




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
logger 0 "-blank"
logger 0 "-header"
logger 1 "Stopping script"
logger 0 "-header"
