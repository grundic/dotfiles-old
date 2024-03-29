#!/usr/bin/env/bash

# If not running interactively, don't do anything
[ -z "${PS1}" ] && return

################################################################################
# Preconfiguration section
################################################################################

# Find own's directory (http://stackoverflow.com/a/246128)
SOURCE="${BASH_SOURCE[0]}"
while [ -h "${SOURCE}" ]; do # resolve $SOURCE until the file is no longer a symlink
  MYDIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
  SOURCE="$(readlink "${SOURCE}")"
  # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ ${SOURCE} != /* ]] && SOURCE="${MYDIR}/${SOURCE}"
done
MYDIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"

# The only function that must be in this file.
# Others shoul be placed in bash_functions.d
function include_d {
  dir=${MYDIR}/.bash-lib/${1}.d
  if [ -d ${dir} -a -r ${dir} -a -x ${dir} ]; then
    for i in $(find ${dir}/ -name *.bash); do
      source ${i}
    done
  fi
}

include_d bash_configuration
include_d bash_functions
include_d bash_aliases
include_d bash_completion

################################################################################
# Global bash configuration section
################################################################################

# PATH configuration
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  :
elif [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
elif [[ "$OSTYPE" == "cygwin" ]]; then
  :
fi

# Command completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Set the default editor to vim.
export EDITOR=vim

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

force_color_prompt=yes

# add colors to `ls` command
CLICOLOR=1
LSCOLORS=gxgxcxdxbxegedabagacad

export CLICOLOR LSCOLORS

eval `gdircolors ${MYDIR}/.bash-lib/dircolors-solarized/dircolors.ansi-dark`
