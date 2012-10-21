MATE shortcuts
==============

Simple [Python](http://www.python.org/) script that sets up keyboard shortcuts 
I use in [MATE](http://mate-desktop.org/) desktop environment in 
[Linux Mint](http://linuxmint.com). I was just tired
of manually setting up these shortcuts every time I reinstalled the system :)


Dependencies
------------

Beside obvious dependency on MATE desktop environment. Main script 
`setup_shortcuts.py` requires Python 2.5. Script for positioning windows
`resize_window.bash` requires program `wmctrl`.


Usage
-----

1. Get the scripts: `git clone https://github.com/prvak/shortcuts.git`
2. Modify shortcuts to your likings: `vi shortcuts.cfg `
3. Setup the shortcuts: `python ./setup_shortcuts.py` (this should be run from 
the scripts directory)
4. Logout and login for the shortcuts to take effect.

---------

  Michal
