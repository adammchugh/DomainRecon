#!/bin/bash

TODAY=`date --date="-2days " +"%Y-%m-%d"`
echo "[DEBUG] Date: $TODAY"

FILENAME="$TODAY.zip"
FILENAME_NO_WHITESPACE="$(echo -e "${FILENAME}" | tr -d '[:space:]')"
echo "[DEBUG] Filename: $FILENAME_NO_WHITESPACE"

FILENAMEB64=`echo $FILENAME_NO_WHITESPACE | base64`
FILENAMEB64_NO_WHITESPACE="$(echo -e "${FILENAMEB64}" | tr -d '[:space:]')"
echo "[DEBUG] FilenameB64: $FILENAMEB64"

DIR="./"

URL="https://whoisds.com/whois-database/newly-registered-domains/$FILENAMEB64_NO_WHITESPACE/nrd"
echo "[DEBUG] Downloading $URL"

wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" "$URL" -O domains.zip
