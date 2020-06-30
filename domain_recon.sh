#!/bin/bash

TODAY=`date --date="-1day" +"%Y-%m-%d"`
echo "[DEBUG] Date: $TODAY"

FILENAME=`echo "$TODAY.zip" | base64`
echo "[DEBUG] Filename: $FILENAME"

DIR="./"

URL="https://whoisds.com/whois-database/newly-registered-domains/$FILENAME/nrd"
echo "[DEBUG] Downloading $URL"

TMP=`mktemp ./XXXXXX.zip`
LOG=`mktemp ./XXXXXX.log`

[ -d "$DIR" ] || mkdir -p $DIR
[ -r "$DIR/$TODAY.txt" ] && rm "$DIR/$TODAY.txt"

wget -o $LOG -O domains.zip $URL
RC=$?
if [ "$RC" != "0" ]; then
  echo "Cannot fetch URL"
  cat $LOG
else
  unzip -d $DIR $TMP >$LOG 2>&1
  RC=$?
  if [ "$RC" != "0" ]; then
    echo "Cannot unzip $TMP"
    cat $LOG
  else
    [ -r "$DIR/domain-names.txt" ] && mv "$DIR/domain-names.txt" "$DIR/$TODAY.txt"
    rm $LOG $TMP
  fi
fi
