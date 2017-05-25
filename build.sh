#!/usr/bin/env bash

dir=`pwd`

mkdir -p $dir/bin
sml.bat build.sml
./make_executable.sh sml.bat $dir zombies
