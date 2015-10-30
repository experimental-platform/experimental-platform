#!/usr/bin/env bash
set -e

git checkout alpha
git pull
git submodule update --init
git submodule foreach git checkout master
cd platform-ubuntu; git checkout latest; cd ..
cd platform-buildstep; git checkout herokuish; cd ..
git submodule foreach git pull

echo "ALL REPOSITOREIS UPDATED. PLEASE REVIEW, COMMIT AND PUSH NOW."