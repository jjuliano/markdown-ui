#!/usr/bin/env bash

for i in *.md; do
  echo "PROCESSING FILE: $i"
  name="$(basename $i .md)"
  ../exe/markdown-ui $name.md > $name.html

  sed -ie 's/&#xFF1A;/:/g' $name.html 2> /dev/null
  rm -rf $name.htmle
done

for i in docs/*.md; do
  echo "PROCESSING FILE: $i"
  name="$(basename $i .md)"
  ../exe/markdown-ui $i > docs/$name.html

  sed -ie 's/&#xFF1A;/:/g' docs/$name.html 2> /dev/null
  rm -rf docs/$name.htmle
done