#!/usr/bin/env bash

git checkout master -- website

rm -rf about.html button.html index.html docs

ln website/about.html
ln website/index.html
mkdir docs
ln website/docs/button.html docs/button.html
ln website/docs/toc.html docs/toc.html

git add .
git commit -m "$(date) pull from master; updated links."
git push github gh-pages