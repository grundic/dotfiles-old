#!/usr/bin/env bash
set -e

dir=$(pwd)
if [[ ! "${dir}/install/install.sh" -ef "$0" ]]; then
  echo "Please run 'install/install.sh' from dotfiles root folder!"
  exit 1
fi

echo ---------------------------------------------
echo / Installation script for grundics dotfiles /
echo ---------------------------------------------

#-------------------------
# Copy .*.local files
#-------------------------
if ls -U .*.local > /dev/null 2>&1
then
  for dotfile in .*.local ; do
    src_path=${dir}/${dotfile}
    dst_path="${HOME}/${dotfile}"
  
    if [ ! -e ${dst_path} ]; then
      echo "[+] Copying ${dotfile} to ${dst_path}"
      cp ${src_path} ${dst_path}
    else
      echo -e "[-]Skipping ${dotfile}: already exists"
    fi
  done
fi


#-------------------------
# Symlink dotfiles
#-------------------------
files="$(${dir}/install/file_list.sh)"

for dotfile in ${files}; do
  src_path="${dir}/${dotfile}"
  dst_path="${HOME}/${dotfile}"

  [ -e ${src_path} ] || continue

  if [ ! -L ${dst_path} ]; then
    echo "[>] Symlinking ${dotfile} -> ${dst_path}"
    ln -nfs ${src_path} ${dst_path}
  else
    echo -e "[-] Skipping ${dotfile}: already exists"
  fi
done
