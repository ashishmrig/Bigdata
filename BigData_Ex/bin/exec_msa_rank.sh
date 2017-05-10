#!/bin/bash
######################################################################################
# This source code and any resulting object code (collectively, the “Software”) is owned by  Ashish Mrig ('AUTHOR')
# Additionally, AUTHOR holds the copyright in the Software.
#
# USE, DISCLOSURE OR TRANSFER OF THE SOFTWARE SHOULD NOT OCCUR WITHOUT CONSENT OF AUTHOR
######################################################################################


# check input argument
function display_usage() {

    echo "usage: $0 -d db_name -q quiet_flag"
    echo " -d : database name"
    echo " -q : run quietly flag: 1=quiet 0=verbose"
    exit 1
} 

# log messages to STDOUT or Log File
function log() {
    if [[ $quiet -eq 1 ]]; then
        [ ! -f $RUNTIME_LOG_FILE ] && touch $RUNTIME_LOG_FILE
        echo "$@" >> $RUNTIME_LOG_FILE
    else
        echo "$@"
    fi
}

##### Start of MAIN code block ######
## Start processing and cwsetup enviornment
log "$(date +"%x %r %Z") Starting job $0 "
env_set=setup_env.sh

## Load environment properties file
source ./$env_set

#Parse the input options
while getopts "d:q:" opt 
do
    case "$opt" in
    d)
        db_name=$OPTARG
        ;;
    q)  quiet=$OPTARG
        ;;
    *)  echo "Invalid command line options"
        display_usage
        ;;
    esac
done

## Load hive properties file
init_file=$base_loc/conf/conf-init.rc

## Compile all the ddls
sql_file=$base_loc/ddl/*.sql

for ddl_file in $sql_file
do
  log "$(date +"%x %r %Z") Compiling the ddl file $ddl_file"
  hive -hivevar hive_db=$db_name -i $init_file -f $ddl_file

  status=$?
  if [ $status != 0 ]
  then
    log "Error in compiling ddl $ddl_file"
    exit 1
  fi
done

#ETL script to process and load the data into 
etl_scr=$base_loc/etl/etl_load_msa_rank.sql
log "$(date +"%x %r %Z") Start execute of ETL script $etl_scr"
hive -hivevar hive_db=$db_name -i $init_file -f $etl_scr
status=$?
  if [ $status != 0 ]
  then
    log "Error in etl script $etl_scr"
    exit 1
  fi

log "$(date +"%x %r %Z") Completion of job $0 "
##### END of MAIN code block ######
