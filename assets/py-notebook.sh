#!/usr/bin/env bash

set -e

GIT_CONFIG="/home/jupyter/.gitconfig"

git config -f $GIT_CONFIG user.name "${name}"
git config -f $GIT_CONFIG user.email "${email}"
