#! /usr/bin/env bash

THEMES="$HOME/.Xresources.d/themes"
THEME="$THEMES/nord.sh"

function Menu() {
    local t count=1
    local name
    for t in $*; do
        name=$(cut -f1 -d. <<< $(basename $t))
	echo "[ $count ]  $name"
	((count ++))
    done

}

function SelectMode() {
    local themes=($(ls $THEMES/*.sh))
    local input=""

    if [[ ${#themes[@]} -ne 0 ]]; then
	 Menu ${themes[@]}
         read -p "* Select one option: " input
         if [[ $input -ge 0 && $input -lt ${#themes[@]} ]]
	     THEME=${themes[$input-1]}
	     echo "Sucesso!"
	 else
             echo "Valor inválido"
	 fi
    else
        exit 1
    fi
	    
}


function Main {
    case "$1" in
        -i)
	     SelectMode
	     ;;
	*)
	    return 0
	    ;;
    esac
}

Main $@

. $THEME 

sed -rn '{
    s/#//
    s|([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})|\1/\2/\3|
    w colors.property
}' <<EOF
!=> $THEME

*background:rgb:$background
*foreground:rgb:$foreground

*color0:rgb:$color0
*color1:rgb:$color1
*color2:rgb:$color2
*color3:rgb:$color3
*color4:rgb:$color4
*color5:rgb:$color5
*color6:rgb:$color6
*color7:rgb:$color7

*color8:rgb:$color8
*color9:rgb:$color9
*color10:rgb:$color10
*color11:rgb:$color11
*color12:rgb:$color12
*color13:rgb:$color13
*color14:rgb:$color14
*color15:rgb:$color15

EOF

