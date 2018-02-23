# cdf
change working directory to finder directory

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
