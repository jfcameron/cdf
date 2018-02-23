# cdf

## Description
Change working directory to finder directory

## Usage
Add the following alias to your bash profile:

    alias cdf=". /path/to/cdf.sh"

then use cdf at any time to change the current directory of your interactive bash session to the directory of the topmost finder window.

    #---------------------------------------------------------------------
    #
    # cdf.sh -- help info
    #
    # Summary:
    #   Change current directory to the Finder's front most window's 
    #   directory. MacOS only!
    #
    # Example Usage:
    #   cdf
    #
    # cdf.sh: [ -h NOARG ]
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
    #     alias cdf=". /path/to/cdf.sh"
    #
    # Author:
    #   Written by Joseph Cameron
    #   Created on 2018-02-22.
    #
    # Implementation based on this Macworld thread circa Oct 2005: 
    #  http://hints.macworld.com/article.php?story=20050924210643297
    #
    #---------------------------------------------------------------------
