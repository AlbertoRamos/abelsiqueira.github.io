#!/bin/bash

cats=($(grep "^  [a-z]" _config.yml | sed 's/  \(.*\):/\1/g'))
N=${#cats[@]}

r=0
while [ $r -lt 1 -o $r -gt $N ]; do
  echo "Choose a category for this new post:"
  for i in $(seq 0 $(($N-1)))
  do
    echo $(($i+1)) ${cats[$i]}
  done
  read r
  if [ $r -lt 1 -o $r -gt $N ]; then
    echo "Choose a number between 1 and $N"
  fi
done

echo -n "Post title: "
read title

today=$(date +"%Y-%m-%d")

filename=$today-$(echo $title | tr '[:upper:] ' '[:lower:]-').markdown

cat > _posts/$filename << EOF
---
layout:     post
title:      $title
date:       $today
categories: ${cats[$(($r-1))]}
---
EOF

vim _posts/$filename