#!/usr/bin/env bash
set -euo pipefail
# shellcheck shell=bash

CONFIG_FILE=$1

failed=$(go run github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest run ./... "$CONFIG_FILE")

if [ -n "${failed}" ]; then
  echo "${failed}"
  exit 1
fi
exit 0
