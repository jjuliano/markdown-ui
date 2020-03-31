#!/usr/bin/env bash

for i in *.md docs/*.md ; do
  echo "PROCESSING FILE: $i"
  dname="$(dirname $i)"
  name="$(basename $i .md)"
  ../exe/markdown-ui $dname/$name.md > $dname/$name.html

  sed -ie 's/&#xFF1A;/:/g' $dname/$name.html 2> /dev/null
  sed -ie 's/PAYPAL_BUTTON/https\:\/\/www\.paypal\.com\/cgi\-bin\/webscr\?cmd\=\_s\-xclick\&hosted_button_id=RVL2DAA4Y6NXL/g' $dname/$name.html 2> /dev/null
  rm -rf $dname/$name.htmle
done