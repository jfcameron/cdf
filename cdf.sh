#!/usr/bin/env bash

#---------------------------------------------------------------------
# Help & About
#---------------------------------------------------------------------
printHelp () {
sed 's/^# \{0,1\}//' << Help
#---------------------------------------------------------------------
#
# $progName -- help info
#
# Summary:
#   Change current directory to the Finder's front most window's 
#   directory. MacOS only!
#
# Example Usage:
#   $noAffixProgName
#   $noAffixProgName back
#
# $shortProgName: [ -h, NOARG, b/back ]
#
#   option: -h
#     print this help page
#
#   option: NOARG
#     changes current dir of interactive bash session to finder's 
#     topmost window's dir.
#
#   option: b/back
#     restore current directory to the one before last cdf. 
#
# Config:
#   add following alias to your .bash_profile: 
#     alias $noAffixProgName=". /path/to/$shortProgName"
#
# Author:
#   Written by Joseph Cameron
#   Created on 2018-02-22.
#
# Implementation based on this Macworld thread circa Oct 2005: 
#  http://hints.macworld.com/article.php?story=20050924210643297
#
#---------------------------------------------------------------------
Help
}

#---------------------------------------------------------------------
# Print info, warning, or error and eit
#---------------------------------------------------------------------
Error() { echo -e "$shortProgName: \033[1;31mError:\033[0m"   "$@" >/dev/stderr; }

# ---------------------------------------------------------------------
# Implementation
# ---------------------------------------------------------------------
_cdf()
{
  export JFCAMERON_CDF_LAST_DIR="$(pwd)"

  currentFinderDir=$( /usr/bin/osascript <<EOT
    tell application "Finder"
      try
        return POSIX path of (folder of the front window as alias)
      on error
        return "ERROR"
      end try
    end tell
EOT
  )
    
  if [ "$currentFinderDir" = "ERROR" ]; then
    Error "could not change directory. Either Finder is closed or viewing a non directory (e.g: \"All My Files\")."
  else
    cd "$currentFinderDir"
  fi
}

_back()
{
  if [ -z ${!JFCAMERON_CDF_LAST_DIR+x} ]; then
    cd $JFCAMERON_CDF_LAST_DIR
  fi
}

#---------------------------------------------------------------------
# Mainline begins here
#---------------------------------------------------------------------
progName=cdf.sh
shortProgName=cdf.sh
noAffixProgName=cdf

if [ $# == 0 ]; then
  _cdf
else
  while true; do 
    case $1 in
      -h | --help) 
        printHelp
      ;;

      b | back)
        _back
      ;;

      *) 
        if [ "${1}" != '' ]; then
          Error "unrecognized option: '$1' Use '-h' for help"
        fi
        break
      ;;
    esac
    shift
  done
fi
