#!/usr/bin/env bash

dir=`pwd`
mkdir -p $dir/bin
sml build.sml

cat > "$dir/bin/zombies" <<EOF
#! /bin/sh
exec sml @SMLcmdname=\$0 @SMLload="$dir/bin/.heapimg" "\$@"
EOF

chmod a+x "$dir/bin/zombies"
