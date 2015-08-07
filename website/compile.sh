#!/usr/bin/env bash

for i in *.md; do
  name="$(basename $i .md)"
  ../exe/markdown-ui $name.md > $name.html

  rpl "#home" "http://jjuliano.github.io/markdown-ui" $name.html
  rpl "#github" "https://github.com/jjuliano/markdown-ui" $name.html
  rpl "：" ":" $name.html
done