<div align="center">
  <img src="" alt="Logo" height="320">  

  ### Balam Dotfiles  
  
  This repository contains my dotfiles (default theme) for [BalamOS](https://github.com/BICH0/balamOs) you can clone this repository and edit your files as you wish, if you want to make them available for everyone to install refer to the [HowTo Customize](#howto)
  
  [**Explore the docs »**](https://github.com/BiCH0/balam)  
[Report Bug](https://github.com/BiCH0/eoka/issues) · [Request Feature](https://github.com/BiCH0/eoka/issues)
  
</div>

# Index
* ### [Installation](#🚀-installation)
* ### [Previews](#📷-previews)
* ### [HowTo Customize](#☕-howto-customize)
* ### [License](#-license)

# 🚀 Installation
To install this repository follow these easy steps

```bash
git clone https://github.com/BiCH0/balam-dotfiles.git && cd balam-dotfiles
```
Once cloned successfully you need to execute the following commands:
```bash
sudo cp -r ohmyzsh-themes/* $(echo $ZSH)/themes/ #This will add the oh-my-zsh themes to the themes folder
sudo cp -r skel/. /etc/skel #This will apply the dotfiles to any new user
sudo cp -r skel/. ~ #This will apply the dotfiles to the current user
sudo cp -r root/. /etc/root #This will apply the dotfiles to the root user
```
The following command is only necessary if you are using ly as your session manager
>[!TIP]
>To know if you have ly enabled use the following command
>```bash
>ll /etc/systemd/system/display-manager.service #It should point to ly.service
>```
```bash
sudo cp ly.conf /etc/ly/config.ini
```

# 📷 Previews
## Description
```
DE/WM: i3
LockScreen: i3lock-colors
Terminal: Alacritty
Tools: cmatrix, tty-clock
```
## Dircolors
![Dircolors](/previews/dircolors.png)

## Prompts
### Normal user
![Prompt](/previews/prompt.png)

### Root
![Root prompt](/previews/root.png)

## Ranger
![Ranger](/previews/ranger.png)

## Ly
![Ly Preview](/previews/ly.png)

## DE/WM
![Empty Desktop](/previews/desktop_empty.png)
![Populated Desktop](/previews/desktop_populated.png)

## Lockscreen
![Lockscreen](/previews/lockscreen.png)

## Rofi
### App launcher
![App launcher](/previews/app_launcher.png)

### Powermenu
![Powermenu](/previews/powermenu.png)

### Greenclip
![Greenclip](/previews/greenclip.png)

## Dunst
![Dunst](/previews/dunst.png)



## Gtk apps
![GTK](/previews/gtk.png)


# ☕ HowTo Customize
In this section you will learn all the things needed to create your own balam-dotfiles and use them in balamOS (or any linux distro really)

## Setting up the repository
Firstly, you will need to create a github repository named balam-dotfiles.

>[!WARNING]
>The repository needs to be public and named balam-dotfiles if you want other users to use it.

```bash
mkdir balam-dotfiles && cd !$ && git init
```
Once your local repository is created you have to set up the upstream repo (if you haven't created the repo in your github profile yet, now is the time)

```bash
git remote add origin git@github.com:<yourname>/balam-dotfiles.git
```
Now check if it was correctly set up by pushing it

```bash
git commit -m "Initial commit" && git push
```
Once the commit submits you should have a nice base, but for the dotfiles to be available in the balam-installer you need to create a branch named release.
```bash
git checkout -b release
```
Now your repo is done, this is how it shoud look like this
```
https://github.com/<yourname>/balam-dotfiles.git
    ├╶ https://github.com/<yourname>/balam-dotfiles/tree/master # <- Main branch
    └╶ https://github.com/<yourname>/balam-dotfiles/tree/release
```
>[!WARNING]
>The branches should contain the following content:
>- master/main: This branch contains all the dotfiles, along with the README.md, LICENSE, check-dots.sh and previews
>- release: This branch should only contain the dotfiles, this will prevent the user to download innecesary data and thus speed up the installation

## Creating/editing your dotfiles
This step is the most important and the longest one, you will need to create/edit/download all the dotfiles needed for the final environment. Balam uses the following components and they are __NEEDED__ any repository that doesn't contain them won't be pushed to upstream.

### Understand Balam structure
The first step is to understand what each component does, so here is a brief description of each one:

- [ly](https://github.com/fairyglade/ly): Display manager, this component is responsible for displaying the login screen.
- [i3](https://github.com/i3/i3): Window manager, is the equivalent of a desktop environment but much more 1337, it draws the windows and manages them.
- [i3-lock](): BalamOs actually uses a modified version which you can find [here](), i3lock is just what it sounds like, a lock screen for i3.
- [polybar](https://github.com/polybar/polybar): This program is the hearth of a nice wm environment, it draws a single (or multiple) status bars with different components, showing relevant info such as current workspace, system tray...
- [dunst](https://github.com/dunst-project/dunst): Notification daemon, shows a pretty window with the system notifications such as messages, discord calls, network status...
- [rofi](https://github.com/davatorium/rofi): Rofi is an alternative to dmenu, it can be used to generate menus, in BalamOs you can find it in the power menu, clipboard and app launcher.
- [greenclip](https://github.com/erebe/greenclip): Clipboard manager integrated with rofi.
- [alacritty](https://github.com/alacritty/alacritty): GPU Accelerated terminal emulator.
- [ranger](https://github.com/ranger/ranger): Ranger is a tui file explorer, its fast, powerfull and very light.
- [flameshot](https://github.com/flameshot-org/flameshot): Screenshot software, its a powerfull tool that lets you take screenshots.
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh): Open Source framework for managing zsh configuration.


### Needed files
Your repo must contain at least the following files (refer to the list above to understand each file content)
```
ohmyzsh-themes
 ├╶ balamos.zsh-theme          # This file contains the ohmyzsh prompt for the users
 └╶ balamosr.zsh-theme         # This file contains the ohmyzsh prompt for root
root
 ├╶ .zlogin                    # This file is empty, otherwise it will execute every time root logins (after .zshrc)
 └╶ .zshrc                     # It can be a copy of /skel/.zshrc, but dont forget to change the ZSH_THEME for the 1337 looks
skel
 ├╶ .zshrc                     # Here you can put all your aliases, set your plugins and much more, refer to ohmyzsh for more info
 └╶ .config
     ├╶ i3
     │   └╶ config             # i3 config file
     ├╶ polybar
     │   └╶ config.ini         # Polybar config file
     └╶ rofi
         └╶ config.rasi        # Rofi config file
ly.conf                        # Ly config file (IMPORTANT, balam is configured to use tty7, ly will fail to launch if not setted here)
tools.list                     # File with your 1337 toolset, can be pacman apps or aur repos (check out mine for the syntax)
```

### Recommended files
These files are not needed but very much recommended
```
skel
 └╶ .config
 │   ├╶ alacritty
 │   │   └╶ alacritty.toml              # Alacritty config file
 │   ├╶ dunst
 │   │   └╶ dustrc                      # Dunst config file
 │   ├╶ flameshot
 │   │   └╶ flameshot.ini               # Flameshot config
 │   ├╶ gtk-3.0
 │   │   ├╶ colors.css                  # Colors for the gtk 3.0 apps
 │   │   ├╶ gtk.css                     # Just a import for the colors.css
 │   │   └╶ settings.ini                # GTK 3.0 settings
 │   ├╶ gtk-4.0
 │   │   ├╶ colors.css                  # Colors for the gtk 4.0 apps
 │   │   ├╶ gtk.css                     # Just a import for the colors.css
 │   │   └╶ settings.ini                # GTK 4.0 settings
 │   ├╶ i3
 │   │   ├╶ i3lock.sh                   # This is a wrapper for the i3lock program, set all the settings here and bind it on i3, polybar and wherever you want.
 │   │   └╶ logout.sh                   # Wrapper for lockscreen, since i3lock doesnt allow config files all the options need to be supplied as comments arguments, you need to bind it as needed.
 │   |   └╶ polybar.sh                  # This script launches a polybar session for each screen, to use it add this line to .config/i3/config: exec_always --no-startup-id ~/.config/i3/polybar.sh
 │   ├╶ ranger
 │   │   ├╶ rc.conf                     # Ranger config file
 │   │   ├╶ rifle.conf                  # Ranger file that specifies default program for each filetype
 │   │   └╶ scope.sh                    # Same as rifle but you can fine grain the behaviour of ranger
 │   ├╶ systemd
 │   │   └╶ user
 │   │       ├╶ pipewire-pulse.service  # Symbolic link to /usr/lib/systemd/pipewire-pulse.service
 │   │       └╶ pipewire-pulse.socket   # Symbolic link to /usr/lib/systemd/pipewire-pulse.socket
 │   ├╶ dircolors                       # This file contains the color codes for each filetype, it needs to be loaded from .bashrc/.zshrc/... with the line: eval $($HOME/.config/dircolors)
 │   └╶ greenclip.toml                  # Greenclip config file
 └╶ .mozilla
     └╶ firefox
         ├╶ default.default-release     # Firefox's default profile directory
         │   └╶ ...                     # Firefox config files (they are a bunch so just cp them)
         └╶ mozilla.sh                      # Script that loads the firefox's default profile
```

### Other files
This repo doesn't contain all the dotfiles for every known app, if you think i should add any app just tell me and i will check it out!!  
[Ask for a new dotfile](https://github.com/BICH0/balam-dotfiles/issues/new)

### Check all files
The file [check-dots.sh](/check-dots.sh) checks all the needed files and its permissions and warns you if any recommended file is not found

## Showcase your work
Once everything is complete, all your dotfiles are placed in the repository, the colors and borders are pixel perfect, it only needs to be shown to the world!! Take some screenshots so people can preview what your h4xx0r rig looks like.

### Description
Add a little description of what is shown on the screenshots, see [my description](#description) to take some inspiration

### Dircolors
This script creates a workspace in your homedir, you just have to take a screenshot and upload it to your README.md

```bash
#!/bin/bash
cd ~
mkdir showcase 
cd !$ || exit 1
git init
touch file
mkdir directory
touch image.png
touch video.mp4
touch audio.mp3
touch compressed.tgz
ln -s file symbolic
ln -s link broken
touch exec
chmod +x exec
touch capability
sudo setcap 'cap_net_bind_service=ep cap_net_admin=ep' capability
touch suid
chmod +4000 suid
touch sgid
chmod +2000 sgid
mkdir dir-ow
chmod o+w dir-ow
mkdir sticky
chmod +1000 sticky
mkdir sticky-ow
chmod +1002 sticky-ow

# To show use ls -lrt .
```
### Prompts
>[!WARNING]
>Take the pictures inside the previously created folder (at ~/workspace) or create your own and use `git init` to create an empty repository, this is needed to show the git prompt.

Just take a picture like [this one](#previews) showing the prompt and `sudo su` to take one of the root's prompt

### Programs
Take a screenshoot of each program that you created a dotfile, if you added new ones let them shine!!

#### Ranger
To showcase ranger use the workspace created at [dircolors](#dircolors-1)

#### DE/WM
BalamOs packs i3 as its default window manager, if you installed another one let us know!!  
Take a screenshot of an empty desktop and a populated one, you can use plain terminals or run some tools in them like cmatrix, cbonsai, tty-clock or whatever you want!


# 📜 License
This project is made under the GPLv3 license, refer to the [License]() for more info  
## LICENSE SYNOPSYS
1. Anyone can copy, modify and distribute this software.
2. You have to include the license and copyright notice with each and every distribution.
3. You can use this software privately.
4. You can use this software for commercial purposes.
5. If you dare build your business solely from this code, you risk open-sourcing the whole code base.
6. If you modify it, you have to indicate changes made to the code.
7. Any modifications of this code base MUST be distributed with the same license, GPLv3.
8. This software is provided without warranty.
9. The software author or license can not be held liable for any damages inflicted by the software.


<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/GPLv3_Logo.svg/2560px-GPLv3_Logo.svg.png" width="80" height="15" alt="WTFPL" /></a>
