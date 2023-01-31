#!/bin/sh
symbol_ver=""
symbol_tag=""
symbol_archs="darwin-arm64 darwin-x64 linux-arm64 linux-x64 win32-ia32 win32-x64"
exclude_files="LICENSE LICENSES.chromium.html version"

if [ -z "$1" ]; then
  echo "usage: version [tag]"
  exit
fi

symbol_ver="v$1"

if [ -n "$2" ]; then
  symbol_tag="_$2"
fi

for symbol_arch in $symbol_archs; do
  symbol_zip=electron-$symbol_ver-$symbol_arch-symbols$symbol_tag.zip
  if [ -f $symbol_zip ]; then
    unzip $symbol_zip -x $exclude_files
  else
    echo "missing $symbol_zip"
  fi
done
