#!/usr/bin/env bash
#
# Name:        backup_logs.sh
# Description: Creates a compressed .tar.gz backup of a directory.
# Usage:       ./backup_logs.sh <directory>
# Output:      ~/backups/<dirname>_<YYYYMMDD_HHMMSS>.tar.gz
# Exit codes:  0 = success, 1 = bad or missing argument
# Author:      tamilore-dev
# Created:     2026-10-09
# Notes:       Creates ~/backups if it does not exist.

set -euo pipefail

# Validate the arguments: a directory path is required.

[[ -z "${1:-}" ]] && { echo "Usage: $0 <directory>" >&2; exit 1; }

[[ ! -d "$1" ]] && { echo "Error: argument must be a directory." >&2; exit 1; }

[[ $# != 1 ]] && { echo "Usage: $0 <directory>" >&2; exit 1; }

# Convert the source directory to an absolute path.
source_dir=$(cd "$1" && pwd)

# Store backups in ~/backups, and create the directory if it is missing.
backup_dir="$HOME/backups"

if [[ ! -d "$backup_dir" ]]; then
    echo "Warning: backup directory does not exist: $backup_dir" >&2
    sleep 3 # Fine, I'll do it myself.
    mkdir --parents "$backup_dir"
    echo "Made backup directory: $backup_dir"
fi

# Build a unique archive name from the directory name and the current time.
timestamp=$(date '+%Y%m%d_%H%M%S')
archive_name="$(basename "$source_dir")_${timestamp}.tar.gz"
archive_path="$backup_dir/$archive_name"

# Compress the contents of the source directory into the archive.
tar -czf "$archive_path" -C "$source_dir" .

echo "Backup completed: $archive_path"

# Record the date, time, and archive path in the log file.
echo "$(date '+%Y-%m-%d %H:%M:%S') - archived $source_dir to $archive_path" >> "$backup_dir/archive.log"
