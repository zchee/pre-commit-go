#!/usr/bin/env bash
set -euo pipefail
# shellcheck shell=bash

files=$(go run github.com/zchee/goimports-rereviser/v4@latest -use-cache=true -cache-fast-skip=true -format -rm-unused -set-alias -recursive . "$@")

echo "$files"
if [ -n "$files" ]; then
  exit 1
fi
