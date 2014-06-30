#! /bin/bash

set -e # any command return if not equal to zero
clear

COLOUR_RED="\33[31m"
COLOUR_GREEN="\33[32m"
COLOUR_DEFAULT="\33[0m"

LOG_DIR="./log"

TEST_FILES_SIZES="63 64 65 127 128 129 4095 4096 4097 959 960 961 1048575 1048576"

printf "Init script for generating data necessary for DFU test script"

if [ ! -d $LOG_DIR ]; then
    `mkdir $LOG_DIR`
fi

for size in $TEST_FILES_SIZES
do
    FILE="./dat_$size.img"
    if [ ! -f $FILE ]; then
	dd if=/dev/urandom of="./dat_$size.img" bs=$size count=1 > /dev/null 2>&1 || exit $?
    fi
done
dd if=/dev/urandom of="./dfudummy.bin" bs=1024 count=1 > /dev/null 2>&1 || exit $?

printf "$COLOUR_GREEN OK $COLOUR_DEFAULT \n"

exit 0
