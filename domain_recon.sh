#!/bin/bash

TODAY=`date --date="-2days " +"%Y-%m-%d"`
echo "[DEBUG] Date: $TODAY"

FILENAME=`echo "$TODAY.zip" | base64`
echo "[DEBUG] Filename: $FILENAME"

DIR="./"

URL="https://whoisds.com/whois-database/newly-registered-domains/$FILENAME/nrd"
echo "[DEBUG] Downloading $URL"

wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" "$URL" -O domains.zip
