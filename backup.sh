#!/bin/bash
:<<  'EOF'
 this is a script for backup with 5 day rotation

usage :
./backup.sh <path to your source> <path to backup folder>

EOF


function display_usage {

        echo "usage : ./backup.sh <path to your source> <path to backup folder>"
}
if  [ $# -eq 0 ]; then
        display_usage
fi


source_dir=$1
backup_dir=$2
timestamp=$( date '+%y-%m-%d-%H-%M-%S')


function create_backup {
        zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}"
        if [  $? -eq 0 ]; then
        echo "Backup generated successfully for ${timestamp}"
        fi
}

function perform_rotation() {
    backupfolder=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))  # List backups sorted by time (newest first)

    if [ "${#backupfolder[@]}" -gt 5 ]; then
        echo "Performing rotation for backups older than the last 5."

        backups_to_remove=("${backupfolder[@]:5}")  # Get all backups older than the last 5

        for backup in "${backups_to_remove[@]}";
	 do
            rm -f "${backup}"
        done
    fi
}
create_backup
perform_rotation
