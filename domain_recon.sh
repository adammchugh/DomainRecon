#!/bin/bash

TODAY=`date --date="-1day" +"%Y-%m-%d"`
FILENAME=`echo "$TODAY.zip" | base64`
DIR="./"
URL="https://whoisds.com/whois-database/newly-registered-domains/$FILENAME/nrd"
TMP=`mktemp ./domain_recon.zip`
LOG=`mktemp ./domain_recon.log`

[ -d "$DIR" ] || mkdir -p $DIR
[ -r "$DIR/$TODAY.txt" ] && rm "$DIR/$TODAY.txt"

wget -o $LOG -O $TMP $URL
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
