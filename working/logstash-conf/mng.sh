#!/bin/bash
search_dir=/workspace/WH003
for entry in "$search_dir"/*
do
  echo "$entry"
  mkdir a
  cp "$entry" ./a
  cd ./a
  ls "$entry" | xargs -n1 tar -xzf
  cp N779XY-LOG-SYSTEM-messages-*.log ../
  rm *
  cd ..
  rm -rf "$entry"
done
