#!/usr/bin/env bash

set -e

readonly PROGNAME=$(basename $0)
readonly PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly ARGS="$@"

cd -- "$(dirname "$BASH_SOURCE")"

git fetch --all
git checkout gh-pages
git pull
git push
git checkout dev
git merge gh-pages
git push
git checkout stage
git merge dev
git push
git checkout prod
git merge stage
git push
git checkout gh-pages
