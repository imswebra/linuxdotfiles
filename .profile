# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


# Dotfile management
alias linuxdf='/usr/bin/git --git-dir=$HOME/.linuxdotfiles/ --work-tree=$HOME'

# WSL/Windows aliases
alias ps.exe="powershell.exe -nologo"
alias e.exe="explorer.exe"

# Linux aliases
alias m=micro
alias cda="cd /mnt/c/Users/ehcla/Sync/assignments/"

# Starship toggle
toggle-nl() {
    if [[ $(sed -n 3p ~/.config/starship.toml) == "disabled = true" ]]; then
        sed -i '3s/disabled = true/disabled = false/' ~/.config/starship.toml
    elif [[ $(sed -n 3p ~/.config/starship.toml) == "disabled = false" ]]; then
        sed -i '3s/disabled = false/disabled = true/' ~/.config/starship.toml
    else
        echo "~/.config/startship.toml doesn't have a disabled statement on line 3!"
    fi
}
