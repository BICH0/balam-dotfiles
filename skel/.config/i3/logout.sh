#!/bin/bash
opt=$(echo -e "󰄬 Yes\n󰅖 No" | rofi -dmenu -mesg "Quit i3?" -theme-str 'mainbox{children: [message, listview];}window {location: center; anchor: center; fullscreen: false; height: 165px; width: 300px;} inputbar{enabled:false;} listview{ layout: horizontal; columns: 2; padding: 10px 20px 0 20px; spacing: 20px;}textbox {horizontal-align: 0.5;} element{padding: 10px 20px;}')
[ ${opt##* } = "Yes" ] && i3-msg exit
