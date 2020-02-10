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

# ==============================================================================

# Verifies that Windows' USERPROFILE is being shared via WSLENV. Returns true if
# shared, false otherwise.
verifyUserProfile() {
    [[ ! -z "$USERPROFILE" ]]
}

# Prompts user to allow Windows' USERPROFILE to be added to WSLENV
shareUserProfile() {
    printf "%s %s %s\n%s %s\n" \
        "\$USERPROFILE is not currently being shared from Windows or is set" \
        "to a blank string. Functions and aliases reliant on \$USERPROFILE" \
        "may not function as expected or at all until it is properly set." \
        "Do you wish to add \$USERPROFILE to your \$WSLENV as a user" \
        "environment variable? [y|n]"
    while true; do
        read yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) return;;
            * ) echo "Please answer (y)es or (n)o.";;
        esac
    done

    echo ""
    echo "Prepending \"USERPROFILE/p\" to \$WSLENV..."
    cmd.exe /c "setx WSLENV USERPROFILE/p:%WSLENV%"
    printf "\n%s\n%s %s" \
        "Done." \
        "Please restart your machine to propogate the Windows environment" \
        "variables changes."
}

# Prompt use to share the user profile if it isn't available already
! verifyUserProfile && shareUserProfile

# Dotfile management
alias linuxdf='/usr/bin/git --git-dir=$HOME/.linuxdotfiles/ --work-tree=$HOME'
verifyUserProfile && alias windowsdf='/usr/bin/git --git-dir=$USERPROFILE/.windowsdotfiles/ --work-tree=$USERPROFILE'

# WSL/Windows aliases
alias ps.exe="powershell.exe -nologo"
alias e.exe="explorer.exe"

# Linux aliases
alias m=micro
verifyUserProfile && alias cdw="cd $USERPROFILE/workspace"

# Git aliases
git() {
    if [[ $1 == "foresta" ]]; then
        command git-foresta --all --style=10 "${@:2}" | less -RSX
    else
        command git "$@"
    fi
}

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
