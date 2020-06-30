#!/bin/bash

TODAY=`date --date="-2days " +"%Y-%m-%d"`
echo "[DEBUG] Date: $TODAY"

FILENAME="$TODAY.zip"
FILENAME_BASE64=$(printf "%s" "$FILENAME" | base64)
echo "[DEBUG] Filename: $FILENAME_BASE64"

DIR="./domains"
[ -d $DIR ] || mkdir $DIR

URL="https://whoisds.com/whois-database/newly-registered-domains/$FILENAME_BASE64/nrd"
echo "[DEBUG] Downloading $URL"

wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" "$URL" -O $DIR/$TODAY.zip

unzip $DIR/$TODAY.zip -d $DIR
rm $DIR/$TODAY.zip
