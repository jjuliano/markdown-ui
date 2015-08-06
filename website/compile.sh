#!/usr/bin/env bash

../exe/markdown-ui index.md > index.html
rpl "#home" "http://jjuliano.github.io/markdown-ui" index.html
rpl "#github" "https://github.com/jjuliano/markdown-ui" index.html
rpl "：" ":" index.html