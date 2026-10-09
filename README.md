# Log Archiver

A small Bash tool that compresses a directory into a timestamped `.tar.gz` backup. Built as a solution to the [roadmap.sh Log Archive Tool](https://roadmap.sh/projects/log-archive-tool) project.

## How it works

1. Checks that you passed exactly one argument and that it is a directory.
2. Converts the path to an absolute path.
3. Creates `~/backups` if it does not exist.
4. Compresses the directory contents into `~/backups/<dirname>_<YYYYMMDD_HHMMSS>.tar.gz`.
5. Appends the date, time, and archive path to `~/backups/archive.log`.

## Requirements

- Bash
- `tar` and `gzip` (installed by default on most Linux distributions)

## Installation

```bash
git clone https://github.com/tamilore-dev/log_archiver ~/log_archiver
cd ~/log_archiver
chmod +x backup_logs.sh
```

## Usage

```bash
./backup_logs.sh <directory>
```

Example:

```bash
./backup_logs.sh ~/test_logs
```

Output:

```
Backup completed: /home/tamilore/backups/test_logs_20261009_143000.tar.gz
```

Each run also adds a line to `~/backups/archive.log`:

```
2026-10-09 14:30:00 - archived /home/tamilore/test_logs to /home/tamilore/backups/test_logs_20261009_143000.tar.gz
```

## Inspecting a backup

```bash
tar -tzf ~/backups/test_logs_20261009_143000.tar.gz   # list contents
tar -xzf ~/backups/test_logs_20261009_143000.tar.gz   # extract
```

## Exit codes

| Code | Meaning |
|---|---|
| 0 | Success |
| 1 | Error (bad argument, or the backup failed) |

## Author

tamilore-dev
