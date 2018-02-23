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
#
# $shortProgName: [ -h NOARG ]
#
#   option: -h
#     print this help page
#
#   option: NOARG
#     changes current dir of interactive bash session to finder's 
#     topmost window's dir.
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
Log()         { echo -e "$shortProgName:" "$@"; }
Info()        { if [ x$verbose = xTRUE ]; then echo "$shortProgName: Info:" "$@"; fi; }
Warn()        { echo -e "$shortProgName: \033[1;33mWarning:\033[0m" "$@"; }
Error()       { echo -e "$shortProgName: \033[1;31mError:\033[0m"   "$@" >/dev/stderr; exit 1; }
Print()       { echo -e "$@"; }
RequiredVar() { if [ -z ${!1+x} ]; then printHelp; Error "Required variable \"${1}\" is unset. Hint: ${2}"; fi; }

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

back()
{
  if [ -z ${!JFCAMERON_CDF_LAST_DIR+x} ]; then
    cd $JFCAMERON_CDF_LAST_DIR
  fi
}

#---------------------------------------------------------------------
# Mainline begins here
#---------------------------------------------------------------------
progName=$0
shortProgName=`echo $progName|sed 's/^.*\///'`
noAffixProgName=`echo $shortProgName|sed 's/\.[^.]*$//'`
verbose=''
initialArgs="$@"

if [ $# == 0 ]; then
  _cdf
else
  while true; do 
    case $1 in
      -h | --help) 
        printHelp
      ;;

      back)
        back
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
