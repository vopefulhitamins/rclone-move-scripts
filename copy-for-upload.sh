#!/bin/bash
torrentid="$1"
torrentname="$2"
torrentpath="$3"
RLCONETEMP="/mnt/rclone-move/"

cp -r "$torrentpath/$torrentname" $RCLONETEMP