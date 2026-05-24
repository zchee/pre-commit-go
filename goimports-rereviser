#!/usr/bin/env bash
set -euo pipefail
# shellcheck shell=bash

files=$(go run github.com/zchee/goimports-rereviser/v4@latest -use-cache -cache-fast-skip -format -rm-unused -set-alias "$@")

echo "$files"
if [ -n "$files" ]; then
  exit 1
fi
