#!/usr/bin/env bash
set -e

dir=$(pwd)
files=

manualfile="${dir}/FILES"

if [ -f ${manualfile} ]; then
  files="$(cat ${manualfile})"
else
  # Get list of files to link
  includes=".vim .zsh"
  excludes="\.git(ignore|modules)|\.swp"
  base="$(find . -maxdepth 1 -name '.*' -not -name '.*.local' -type f | sed 's#^\./##' | grep -vE ${excludes})"
  files="${base} ${includes}"
fi

echo ${files}
