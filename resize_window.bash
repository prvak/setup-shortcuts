#!/bin/bash
# $1 ... top | bottom | left | right
# Based on http://unix.stackexchange.com/a/17983
unset x y w h a
eval $(xprop -root |sed -rne 's/^_NET_WORKAREA\(CARDINAL\) = ([0-9]+), ([0-9]+), ([0-9]+), ([0-9]+).*$/x=\1;y=\2;w=\3;h=\4/p' \
                          -e 's/^_NET_ACTIVE_WINDOW\(WINDOW\): window id # (0x.*)$/a=\1/p')

[[ -z "$a" ]] && exit 1
case "$1" in
	top    ) ((h=(h/2)-20));((w=7*(w/12)-10));;
	bottom ) ((y=y+(h-(h/2)+20)));((h=(h/2)-20));((w=7*(w/12)-10));;
	left   ) ((w=7*(w/12)-10));; # -10 because left and right window overlapped
	right  ) ((x=(w-5*(w/12))));((w=5*(w/12)));;
esac
wmctrl -i -r "$a" -e 0,$x,$y,$w,$h
