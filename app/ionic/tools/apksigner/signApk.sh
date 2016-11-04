#!/bin/sh
if [ "$#" -ne 4 ] || ! [ -f "$1" ]; then
  echo "Usage: $0 input.signed.apk output.signed.apk /path/to/keystore keystore_alias" >&2
  exit 1
fi

apkFullPath=$1
apkUnaligned=$2.unaligned
apkOutFile=$2
keystore=$3
keystoreAlias=$4

cp $apkFullPath $apkUnaligned

jarsigner -verbose  -sigalg SHA1withRSA -digestalg SHA1 -keystore $keystore $apkUnaligned $keystoreAlias  && zipalign -v 4 $apkUnaligned $apkOutFile && rm $apkUnaligned

