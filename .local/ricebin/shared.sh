#!/usr/bin/env bash

LIB_read_env_file_like() {
  # reads env-file-like files and returns the value of a reqested key.
  # $1: path to the file - the path of the file
  # $2: key - key to read
  # result: writes the value under the key to stdout.

  awk -v key=$2 -F'=' '{if (match($1, "^" key "$")) {print $2}}' $1
}
