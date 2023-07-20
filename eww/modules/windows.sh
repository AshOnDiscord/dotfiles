#!/bin/sh

# Checks if a list ($1) contains an element ($2)
contains() {
    for e in $1; do
        [ "$e" == "$2" ] && echo 1 && return
    done
    echo 0
}

print_workspaces() {
    buf=""
    desktops=$(bspc query -N -d -n .window)
    focused_desktop=$(bspc query -N -d -n focused)
    
    for d in $desktops; do
        if [ "$(contains "$focused_desktop" "$d")" -eq 1 ]; then
            class="focused"
          else 
            class="empty"
        fi

        icon="$(xprop -id $d | awk -F '"' '/WM_CLASS/{print $4}')"
        icon="$(tr '[:lower:]' '[:upper:]' <<< ${icon:0:1})${icon:1}"
        
        buf="$buf (eventbox :cursor \"hand\" (button :class \"$class\" :onclick \"bspc node -f $d\" \"$icon\"))"
    done
    
    echo "(box :space-evenly false :class \"windows\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true $buf)"
}

# Listen to bspwm changes
print_workspaces
bspc subscribe desktop node_state desktop_focus node_add node_remove node_focus | while read -r _ ; do
    print_workspaces
done