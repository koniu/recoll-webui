#!/bin/sh
# To open local file:// links from recoll-webui in Opera:
#
# 1. Save this file somewhere in your PATH (eg. /usr/local/bin)
# 2. Go to Tools > Preferences > Advanced > Programs > Add
# 3. In "Protocol" field enter "local-file"
# 4. Select "Open with other application" and enter 'opera-open.sh'
# 5. In recoll webui settings replace all 'file://' with 'local-file://'

HANDLER="opera"
PROTOCOL="local-file:\/\/"
REPLACEMENT="file:\/\/localhost"
URL=`echo $@ | sed -e "s/$PROTOCOL/$REPLACE/"`
$HANDLER "$URL"
