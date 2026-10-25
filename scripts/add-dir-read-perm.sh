#!/bin/bash
TARGET=$1
GROUP=$2

find "$TARGET" -type d -exec setfacl -m g:${GROUP}:rx {} +

find "$TARGET" -type f -exec setfacl -m g:${GROUP}:r {} +
