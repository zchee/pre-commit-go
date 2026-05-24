#!/usr/bin/env bash
set -euo pipefail
# shellcheck shell=bash

files=$(gofumpt -l -w -extra "$@")
echo "$files"
if [ -n "$files" ]; then
  exit 1
fi
