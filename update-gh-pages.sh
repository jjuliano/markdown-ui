#!/usr/bin/env bash

rm -rf website

git checkout master -- website

rm -rf *.html docs

cp -R website/*.html .

mkdir -p docs
cp -R website/docs/*.html docs/.

rm -rf website

git add .
git commit -m "$(date) pull from master; updated links."
git push origin gh-pages
