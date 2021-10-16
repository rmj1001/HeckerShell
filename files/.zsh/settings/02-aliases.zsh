#!/usr/bin/env zsh

############################## SHELL FUNCTIONS ##############################

### Print text to STDOUT without 'echo'
# usage: PRINT "<text>"
PRINT() { printf "%b\n" "${@}" }

### Print text without newline
# usage: NPRINT "<text>"
NPRINT() { printf "%b" "${@}" }

### Run programs silently in the background
# usage: silentrun <program> [args?]
SILENTRUN() { $@ 2>&1 > /dev/null; return $? }

### Run programs in the background in disowned processes
# usage: ASYNC '<commands>'
ASYNC() { nohup $@ > /dev/null 2>&1 & }

### Make all text uppercase
# usage: UPPERCASE "text" -> "TEXT"
UPPERCASE() { NPRINT "$1" | tr '[:lower:]' '[:upper:]' }

### Make all text lowercase
# usage: LOWERCASE "TEXT" -> "text"
LOWERCASE() { NPRINT "$1" | tr '[:upper:]' '[:lower:]' }

### Random number generator
# usage: random <number?>
random() { NPRINT "$(( 1 + ${RANDOM} % ${1:-100} ))" }

### Download youtube videos
# usage: downloadYTVideo <video url>[]
downloadYTVideo ()
{
	# Preparations
	DIR=$HOME/Downloads/VideoDownloader; [[ -d "$DIR" ]] || mkdir "$DIR" ; cd "$DIR"

    youtube-dl --format mp4 -o "%(title)s.%(ext)s" "${@}"
}

### Download youtube videos as MP3 sound files
# usage: mp3dl <video url>[]
mp3dl ()
{
	# Preparations
	DIR=$HOME/Downloads/Music; [[ -d "$DIR" ]] || mkdir "$DIR" ; cd "$DIR"

	# Download
	youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
		--extract-audio --audio-format mp3 "${@}"
}

### Add sound clips to soundfx folder
# usage: soundfx <video url>[]
soundfx ()
{
	# Preparations
	DIR=$HOME/Music/SoundFX; [[ -d "$DIR" ]] || mkdir "$DIR" ; cd "$DIR"

	# Download
	youtube-dl --prefer-ffmpeg --add-metadata --output '%(title)s.%(ext)s' \
		--extract-audio --audio-format mp3 "${@}"
}

############################## SHELL ALIASES ##############################

# Edit files
alias edit="${EDITOR}"
alias rootedit="${AUTH} ${EDITOR}"

# Copy text from STDIN or from a file
alias copy="xclip -sel clip"

# Colorized grep
alias grep="grep --color=auto"

# Cat a file w/ line numbers
alias readfile="/bin/cat -n"

# Replace 'which'
alias which="command -v"

# Check if program exists (silent, use return codes)
alias CMDEXISTS="SILENTRUN command -v"

# If bat/batcat exists, create opposite alias to replace cat
if CMDEXISTS bat; then
	alias batcat="/bin/bat -p"
elif CMDEXISTS batcat; then
    alias bat="/bin/batcat -p"
fi

# Listing files/directories
alias ls="ls --color=auto --group-directories-first"
alias ll="ls -AlvhF"
alias la="ls -A"
alias l.="la | grep '^\.\w\w*$'"

# Directory manipulation
alias mkdir="mkdir -p"
alias md="mkdir"
alias mf="touch"
alias rd="rm -rf"
alias rf="rm -f"
alias rmcd="dir=${PWD}; cd .. && rm -rf ${dir}"
mkcd () { mkdir "${1}" && cd "${1}" }

# File Permissions (Exec/Non-exec)
alias mke="chmod +x"
alias rme="chmod 644"
alias correctGPGperms="chown -R $(whoami) ~/.gnupg/; chmod 600 ~/.gnupg/*; chmod 700 ~/.gnupg"

# Update software from source
alias makeupdate="git pull && sudo make uninstall && make clean && make && sudo make install"

# Install gaming software
alias install-gaming="pip3 install LibreGaming; PRINT '\n\nRun \"LibreGaming --tui\" to install gaming software.'"
alias update-gaming="pip3 install LibreGaming -U; PRINT '\n\nRun \"LibreGaming --tui\" to install gaming software.'"

# Home
alias home="cd ${HOME}"

# Pipewire
alias restart-pipewire="systemctl restart --user pipewire; systemctl restart --user pipewire-pulse; systemctl restart --user bluetooth"

# Default apps
alias terminal="${TERMINAL}"
alias browser="${BROWSER}"
alias auth="${AUTH}"

########################## Pantheon ##########################
alias startPantheon="/usr/bin/gnome-session session=pantheon; ASYNC plank; ASYNC wingpanel"

