#!/bin/bash

# Usage: totp_generate.sh --line=2 --qr
LINE_NUMBER=1
DB_PATH=./seed.db

while [ $# -gt 0 ]; do
	case "$1" in
		--line=*)
		LINE_NUMBER="${1#*=}"
		;;
		--qr)
		GENERATE_QR="1"
		;;
		--database=*)
		DB_PATH="${1#*=}"
		;;
		*)
		printf "************************************\n"
		printf "* 	  Invalid argument 	   *\n"
		printf "************************************\n"
		exit 1
	esac
	shift
done

if [ ! -f "$DB_PATH" ]; then
  echo "File $DB_PATH does not exist"
  exit 1
fi

LINE=`sed -n "$LINE_NUMBER"p "$DB_PATH"`
LABEL=`echo $LINE | awk -F';' '{print $1}'`
ENCODED_LABEL=`python -c "import urllib; print urllib.quote('$LABEL')"`
SECRET=`echo $LINE | awk -F';' '{print $2}'`
URI=`echo "otpauth://totp/$ENCODED_LABEL?secret=$SECRET"`

if [ -n "$GENERATE_QR" ]; then
	qr `echo $URI`
else
	echo $URI
fi
