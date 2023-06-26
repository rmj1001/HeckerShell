#!/usr/bin/env bash

##############################################
#   Author: RMCJ <rmichael1001@gmail.com>
#   Project: backup
#   Version: 1.0
#
#   Usage:
#
#   Description:
#		Backup files
##############################################

##############################################
# PRE-PROCESSING

# shellcheck disable=SC1091
source "${SCRIPTS:=$HOME/.local/bin}"/00-api.sh

DISABLE_ROOT || exit 1

##############################################
# HELP MENU BUILDER

SCRIPT_VERSION="1.5"
SCRIPT_DESCRIPTION="Create Backups of your HOME directory"
SCRIPT_USAGE="[FLAG] [ARGS]? ..."

# Examples
EXAMPLE "--tar -c /mnt/drive" "Create a tarball backup of HOME in /mnt/drive"

# Flags
FLAG "--tar" "" "(Default) Uses tar to backup your files"
FLAG "--rsync" "" "Uses rsync to backup your files"
FLAG "--cp" "" "Uses cp to backup your files (no exclusions)"

##############################################
# MAIN LOGIC

### Variables ###
exclusions="${HOME}/.backup_exclusions"
method="tar"
ARGS=()

function backup.create() {
	clear

	# If the directory doesn't exist, throw an error and exit
	[[ ! -d "${1}" ]] && PRINT "Invalid destination directory!\n" && PAUSE && clear && exit 1

	# Cleanly exit backup process
	trap 'clear; PRINT "Backup Terminated."; PAUSE; clear; exit 0' SIGTERM SIGINT

	local target

	case "${method}" in
	tar)
		target="${1}/${USER}_$(date +m%m-d%d-y%y).tar.gz"

		# Check if tar exists
		REQUIRE_CMD "tar" || return 1

		# Remove duplicate backup
		[[ -f "${target}" ]] && PRINT "Removing duplicate backup..." && rm -rf "${target}"

		# Confirmation
		PRINT "Backing up with tar..."

		# Backups up files, with exclusions if file exists, or without exclusions if no file exists.
		[[ -f "${exclusions}" ]] && tar -zcvpf "${target}" -X "${exclusions}" "${HOME}"
		[[ ! -f "${exclusions}" ]] && tar -zcvpf "${target}" "${HOME}"

		;;
	rsync)
		target="${1}/${USER}_$(date +m%m-d%d-y%y)"

		# Check if rsync exists
		REQUIRE_CMD "rsync"

		# Remove duplicate backup
		[[ -d "${target}" ]] && PRINT "Removing duplicate backup..." && rm -rf "${target}"

		# Confirmation
		PRINT "Backing up with rsync..."

		# Backup all files
		[[ -f "${exclusions}" ]] && rsync -arzvhP --exclude-from="${exclusions}" "${HOME}/" "${target}"
		[[ ! -f "${exclusions}" ]] && rsync -arzvhP "${HOME}/" "${target}"

		;;
	cp)
		target="${1}/${USER}_$(date +m%m-d%d-y%y)"

		# Check if rsync exists
		REQUIRE_CMD "cp"

		# Remove duplicate backup
		[[ -d "${target}" ]] && PRINT "Removing duplicate backup..." && rm -rf "${target}"

		# Confirmation
		PRINT "Backing up with cp..."

		# Backup all files
		cp -vR "${HOME}" "${target}"

		;;
	esac

	# Confirmation
	PRINT "\n\nBackup finished."
	PAUSE
	clear
}

[[ $# -eq 0 ]] && {
	HELP
	exit 0
}

### Flags ###
for arg in "$@"; do
	case "$(LOWERCASE "$arg")" in
	--rsync)
		method="rsync"
		;;

	--tar)
		method="tar"
		;;

	--cp)
		method="cp"
		;;
	-b | --background)
		background=1
		;;
	*)
		ARGS+=("$arg")
		;;
	esac
done

### Argument Handling ###

for arg in "${ARGS[@]}"; do
	case "$(LOWERCASE "${arg}")" in

	-c | --create)
		[[ $background -eq 1 ]] && ASYNC backup.create "${ARGS[1]}"
		backup.create "${ARGS[1]}"
		break
		;;

	-r | --restore)
		[[ $background -eq 1 ]] && ASYNC backup.restore "${ARGS[1]}"
		backup.restore "${ARGS[1]}"
		break
		;;

	-e | --exclusions)
		[[ $background -eq 1 ]] && PRINT "Can't edit exclusions in the background."
		backup.exclusions
		break
		;;

	\? | -h | --help)
		HELP
		break
		;;

	*)
		INVALID_CMD "$(LOWERCASE ${ARGS[0]})"
		exit 1
		;;

	esac
done
