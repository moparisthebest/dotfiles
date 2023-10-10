# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.config/bin" ] && PATH="$HOME/.config/bin:$PATH"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color | alacritty) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

function pdfcat () {
	gs -q -sPAPERSIZE=letter -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=out.pdf "$@"
}

# https://incenp.org/notes/2015/gnupg-for-ssh-authentication.html
# gpg-connect-agent /bye
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

function mkcd() {
  [ -n "$1" ] && mkdir -p "$@" && cd "$1";
}

# https://unix.stackexchange.com/questions/5366/command-line-completion-from-command-history
# Key bindings, up/down arrow searches through history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\eOA": history-search-backward'
bind '"\eOB": history-search-forward'

#if [ -d "$HOME/bin/lib" ] ; then
#    export LD_LIBRARY_PATH="$HOME/bin/lib:$LD_LIBRARY_PATH"
#fi

export EDITOR=nano

which hx &>/dev/null && export EDITOR=hx

export VISUAL=$EDITOR

export PATH="$PATH:$HOME/.cargo/bin"

[ -d /mnt/winegames/bin ] && export PATH="$PATH:/mnt/winegames/bin"

function spurdo() {
sed "s/kek/geg/gI;s/epic/ebin/gI;s/america/clapistan/gI;s/right/rite/gI;s/your/ur/gI;s/\./ :DD/gI;s/'//gI;s/,/XDD/gI;s/wh/w/gI;s/th/d/gI;s/af/ab/gI;s/ap/ab/gI;s/ca/ga/gI;s/ck/gg/gI;s/co/go/gI;s/ev/eb/gI;s/ex/egz/gI;s/et/ed/gI;s/iv/ib/gI;s/it/id/gI;s/ke/ge/gI;s/nt/nd/gI;s/op/ob/gI;s/ot/od/gI;s/po/bo/gI;s/pe/be/gI;s/pi/bi/gI;s/up/ub/gI;s/va/ba/gI;s/ck/gg/gI;s/cr/gr/gI;s/kn/gn/gI;s/lt/ld/gI;s/mm/m/gI;s/nt/dn/gI;s/pr/br/gI;s/ts/dz/gI;s/tr/dr/gI;s/bs/bz/gI;s/ds/dz/gI;s/es/es/gI;s/fs/fz/gI;s/gs/gz/gI;s/ is/iz/gI;s/as/az/gI;s/ls/lz/gI;s/ms/mz/gI;s/ns/nz/gI;s/rs/rz/gI;s/ss/sz/gI;s/ts/tz/gI;s/us/uz/gI;s/ws/wz/gI;s/ys/yz/gI;s/alk/olk/gI;s/ing/ign/gI;s/ic/ig/gI;s/ng/nk/gI" \
<<< "${@:-$(cat /dev/stdin)}"
}

function randomcase() {
while IFS='' read -r -d '' -n 1 char
do    
    printf %s "$char" | ( [ $(( $RANDOM % 2 )) -eq 0 ] && tr '[[:lower:]]' '[[:upper:]]' || tr '[[:upper:]]' '[[:lower:]]' )
done <<< "${@:-$(cat /dev/stdin)}"
}

#export RUSTC_WRAPPER=sccache
export CARGO_TARGET_DIR=/tmp/cargo-target

# this has to be last
if [[ -z "$ZELLIJ" ]]; then
    zellij attach -c
    # uncomment for exit shell when zellij exits
    # exit
fi
