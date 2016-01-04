#!/bin/bash

FILE=${1}

if [ -z "${FILE}" ]; then
    echo "Usage: ${0} <filename>"
    echo
    exit 1
fi

BASENAME=$(basename "${FILE}")
FILENAME=$(basename "${FILE}" .mov)
DIRNAME=$(dirname "${FILE}")

ffmpeg -i "${DIRNAME}/${BASENAME}" -c:v copy -c:a copy "${DIRNAME}/${FILENAME}.mp4"
