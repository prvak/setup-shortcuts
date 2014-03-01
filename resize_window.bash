#!/bin/bash
# $1 ... top | bottom | left | right
# Based on http://unix.stackexchange.com/a/17983
unset x y w h a
eval $(xprop -root |sed -rne 's/^_NET_WORKAREA\(CARDINAL\) = ([0-9]+), ([0-9]+), ([0-9]+), ([0-9]+).*$/x=\1;y=\2;w=\3;h=\4/p' \
                          -e 's/^_NET_ACTIVE_WINDOW\(WINDOW\): window id # (0x.*)$/a=\1/p')

[[ -z "$a" ]] && exit 1
case "$1" in
	maximized) 
		wmctrl -i -r "$a" -b "add,maximized_vert,maximized_horz";;
	not-maximized) 
		wmctrl -i -r "$a" -b "remove,maximized_vert,maximized_horz";;
	shaded) 
		wmctrl -i -r "$a" -b "add,shaded";;
	top-left-thirds) 
		((h=(h/2)-20));
		((w=7*(w/12)-10));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	bottom-left-thirds) 
		((y=y+(h-(h/2)+20)));
		((h=(h/2)-20));
		((w=7*(w/12)-10));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	top-left) 
		((h=(h/2)-20));
		((w=w/2-5));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	bottom-left) 
		((y=y+(h-(h/2)+20)));
		((h=(h/2)-20));
		((w=w/2-5));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	left) 
		((w=w/2-5));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	right) 
		((x=(w-w/2)));
		((w=w/2-5));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	left-thirds) 
		((w=7*(w/12)-10)); # -10 because left and right window overlapped
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
	right-third) 
		((x=(w-5*(w/12))));
		((w=5*(w/12)));
		wmctrl -i -r "$a" -e 0,$x,$y,$w,$h;;
esac
