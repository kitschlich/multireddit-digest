#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd build

git init
git config user.name "Shandra Iannucci"
git config user.email "shandrai@gmail.com"

git remote add upstream "https://kitschlich:$GH_TOKEN@github.com/kitschlich/multireddit-digest.git"
git fetch upstream
git reset upstream/gh-pages

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages
