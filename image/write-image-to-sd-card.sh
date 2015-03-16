#! /bin/bash -exu

. ./utilities.sh

ensure_running_as_root

BASE_DIR=`pwd`
CONFIG_DIR="$BASE_DIR/config"

. $CONFIG_DIR/common.conf

# Getting the image configuration variables
if [ "$#" -ne 2 ]; then
	report_error "Too many or too few parameters (provide image configuration name and device)"
	exit 1
fi

CONFIG_NAME=$1
DEVICE=$2
. $CONFIG_DIR/image.conf

# Checking image file
if [ ! -e $IMAGE_FILE ]
then
	report_error "Please build image first"
	exit 1
fi

# Checking device
if [ ! -e $DEVICE ]
then
	report_error "SD card does not exist"
	exit 1
fi

# Writing image to the SD card
report_info "Writing image to the SD card"

pv -tpreb $IMAGE_FILE | dd of=$DEVICE bs=64M

report_info "Process finished"

exit 0
