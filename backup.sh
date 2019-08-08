log=.log
tar=.tar

archive_path=/root/backup
folder_to_backup=/home
archive_date=$(date "+%F_%T")
archive_name=$archive_date$tar
log_file=$archive_path/logs/$archive_date$log
incremental_file=incremental.snap

run() {
    if [ ! -d "$archive_path" ]; then mkdir -p "$archive_path"; fi
    if [[ $CUSTOM_LOG -eq 0 ]]; then
        if [ ! -d "$archive_path/logs" ]; then mkdir -p "$archive_path/logs"; fi
    fi
	tar \
        -cvvg $incremental_file \
        -f $archive_pathname \
        $folder_to_backup \
        > $log_file
}

usage() {
	echo "USAGE: $0 [OPTIONS]"
	echo
    echo "OPTIONS:"
    echo -e "\t-f BACKUP_FOLDER folder that you want to backup"
    echo -e "\t                 default is /home\n"
    echo -e "\t-g INCREMENTAL_FILE filename of incremental file"
    echo -e "\t                    given to tar -g option\n"
    echo -e "\t-p ARCHIVE_PATH path to store the archive to\n"
    echo -e "\t-l LOG_FILE path to logfile\n"
    echo -e "\t-h display this help message\n"
    echo "NOTES:"
    echo -e "\tdon't ever put the trailing slash to the given paths"
}

while getopts ":f:g:p:h" o; do
	case $o in
		f) folder_to_backup=$OPTARG; ;;
		g) incremental_file=$OPTARG; ;;
		p) archive_path=$OPTARG; ;;
        h) help=1; ;;
        l) log_file=$OPTARG; CUSTOM_LOG=1;;
        *) help=1; ;;
	esac
done
shift $((OPTIND-1))

if [[ $help -eq 1 ]]; then usage; exit; fi

incremental_file=$archive_path/$incremental_file
archive_pathname=$archive_path/$archive_name

# launch backup
run


