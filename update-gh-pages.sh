#!/usr/bin/env bash

rm -rf website

git checkout master -- website

rm -rf *.html docs

cp -R website/*.html .
cp -R website/docs .

git add .
git commit -m "$(date) pull from master; updated links."
git push github gh-pages