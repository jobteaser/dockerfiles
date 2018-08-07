# ClamAV

[ClamAV®](https://www.clamav.net/) is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats.

We are using this docker image to run scans on files and directories.

## How

`start.sh` script passes given args to the `find` command (as in `findutils` Alpine package) and pipes the result to `clamscan`.

Note: `start.sh` script create and/or update the ClamAV database with `freshclam` in the default directory (`/var/lib/clamav`).

## Usage

For example, if you want to scan all files created in the last 60 minutes in a directory, use the following command:
```
$ docker run -it --rm jobteaser/clamav <path to directory to scan> -cmin -60 -type f
```

Note: you can use the `CLAMSCAN_LOGPATH` env var to log to a specific file of your choice.

### Override database

You can mount your ClamAV database into `/var/lib/clamav/main.cvd` to avoid downloading the full database on every run and update only.

### Override configuration

You can mount your specific ClamAV configuration into `/etc/clamav`.
