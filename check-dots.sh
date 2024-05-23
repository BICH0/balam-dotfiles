#!/bin/bash

#  Version: 0.0.1
#  Check script to verify all the dotfiles location and permissions
#  by BiCH0

needed_files="ohmyzsh-themes/balamos.zsh-theme ohmyzsh-themes/balamosr.zsh-theme root/.zlogin root/.zshrc skel/.zshrc skel/.config/i3/config skel/.config/polybar/config.ini skel/.config/rofi/config.rasi ly.conf tools.list"
needed_exec_files=""
needed_symlinks=""
recommended_files="\
skel/.config/alacritty/alacritty.toml \
skel/.config/dunst/dunstrc \
skel/.config/flameshot/flameshot.ini  \
skel/.config/gtk-3.0/colors.css \
skel/.config/gtk-3.0/gtk.css \
skel/.config/gtk-3.0/settings.ini \
skel/.config/gtk-4.0/colors.css \
skel/.config/gtk-4.0/gtk.css \
skel/.config/gtk-4.0/settings.ini \
skel/.config/ranger/rc.conf \
skel/.config/ranger/rifle.conf \
skel/.config/dircolors \
skel/.config/greenclip.toml"
recommended_dirs="\
skel/.mozilla/firefox/default.default-release"
recommended_symlinks="\
skel/.config/systemd/user/pipewire-pulse.service,/usr/lib/systemd/user/pipewire-pulse.service
skel/.config/systemd/user/pipewire-pulse.socket,/usr/lib/systemd/user/pipewire-pulse.socket
"
recommended_exec_files="\
skel/.config/i3/i3lock.sh \
skel/.config/i3/logout.sh \
skel/.config/i3/polybar.sh \
skel/.config/ranger/scope.sh \
skel/.mozilla/firefox/mozilla.sh"

# Colors
RED="\e[0;31m"
GREEN="\e[0;32m"
NC="\e[0m"


check_file(){
    if [ -f "$1" ]
    then
        if [ -x "$1" ]
        then
           return 0
        fi
        return 2
    fi
    if [ -d "$1" ]
    then
        return 3
    fi
    if [ -n "${1//[^,]}" ]
    then
        if [ -L "${1%,*}" ]
        then
            if [ "$(readlink ${1%,*})" == "${1#*,}" ]
            then
                return 4
            fi
            return 5
        fi
    fi
    return 1
}

parse_files(){
    local required=${1:0:1}
    local exec_perm=${1:1:1}
    local directory=${1:2:1}
    shift
    local color="\e[0;31m"
    if [ "$required" -eq 0 ]
    then
        color="\e[0;33m"
    fi
    local res=0
    for file in $@
    do
        echo -n " - "
        check_file $path/$file
        local ecode=$?
        case $ecode in
            0)
                echo -ne "${GREEN}[OK]"
            ;;
            1)
                echo -ne "${color}[NOT FOUND]"
            ;;
            2)
                if [ "$exec_perm" -eq 0 ]
                then
                    echo -ne "${GREEN}[OK]"
                    ecode=0
                else
                    echo -ne "${color}[NO EXEC]"
                fi
            ;;
            3)
                if [ "$directory" -eq 1 ]
                then
                    echo -ne "${GREEN}[OK]"
                    ecode=0
                else
                    echo -ne "${color}[INVALID]"
                fi
            ;;
            4)
                echo -ne "${GREEN}[OK]"
                file=${file%,*}
                ecode=0
            ;;
            5)
                echo -ne "${color}[BROKEN LINK]"
                file="${file%,*} -/> ${file#*,}"
            ;;
        esac
        echo -e "${NC} $file"
        if [ "$res" -eq 0 ] && [ "$ecode" -ne 0 ]
        then
            res=1
        fi
    done
    return $ecode
}

main(){
    pass=0
    path=$1
    if [ ! -d "$1" ]
    then
        echo -e "${RED}You need to supply a directory that contains the dotfiles: $0 <directory>${NC}"
        exit 1
    fi
    echo "Needed files [$(echo $needed_files | wc -w)]:"
    parse_files 100 ${needed_files}
    pass=$(($pass+$?))
    echo -e "\nNeeded files (with execution) [$(echo $needed_exec_files | wc -w)]:"
    parse_files 110 ${needed_exec_files}
    pass=$(($pass+$?))
    echo -e "\nNeeded symlinks [$(echo $needed_symlinks | wc -w)]:"
    parse_files 110 ${needed_symlinks}
    pass=$(($pass+$?))
    echo -e "\nRecomended files [$(echo $recommended_files | wc -w)]:"
    parse_files 000 ${recommended_files}
    echo -e "\nRecomended files (with execution) [$(echo $recommended_exec_files | wc -w)]:"
    parse_files 010 ${recommended_exec_files}
    echo -e "\nRecomended symlinks [$(echo $recommended_symlinks | wc -w)]:"
    parse_files 000 ${recommended_symlinks}
    echo -e "\nRecomended dirs [$(echo $recommended_dirs | wc -w)]:"
    parse_files 001 ${recommended_dirs}
    echo -e "\n"
    return $pass
}
main $*
if [ "$?" -gt 0 ]
then
    echo -e "${RED}[ERROR]${NC} You have some errors, correct them before pushing"
else
    echo -e "${GREEN}Everything seems about right, you are safe to git push${NC}"
fi
echo -e "\n"