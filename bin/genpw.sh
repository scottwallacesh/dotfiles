#!/bin/bash

LENGTH=12
[ ${1} ] && LENGTH=${1}

PW=$(jot -rc 256 48 123 | grep -m${LENGTH} "\w" | rs -g 0 ${LENGTH})

echo -n ${PW}
