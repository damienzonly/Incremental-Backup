# Incremental backup for linux
This script allows you to backup (by default) the home folder incrementally using tar.

## Requirements
- tar
- date (for archive and logs filenames)

## Usage
```
USAGE: ./backup.sh [OPTIONS]

OPTIONS:
	-f BACKUP_FOLDER folder that you want to backup
	                 default is /home

	-g INCREMENTAL_FILE filename of incremental file
	                    given to tar -g option

	-p ARCHIVE_PATH path to store the archive to

	-l LOG_FILE path to logfile

	-h display this help message
```

## Folder structure
The default path for the backup is /root/backup

```
$ tree /root/backup
.
├── 2019-08-08_23:40:54.tar
├── incremental.snap
└── logs
    └── 2019-08-08_23:40:54.log

1 directory, 4 files
```

<br>


## Run
```
sudo ./backup.sh
```

## Run cronjob
```
sudo crontab -e

0 */5 * * *     ./backup.sh
```
to run the backup every 5 hours.

## Run with options
```
./backup.sh -f folder -g inc.snar -p archive.tar -l file.log
```
