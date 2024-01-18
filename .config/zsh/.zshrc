#!/bin/zsh
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
#Hidden files
_comp_options+=(globdots)

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='${vcs_info_msg_0_}'
zstyle ':vcs_info:git:*' formats '%b'


autoload -Uz colors && colors

PROMPT='%F{red}[%n@%m]%3~ %#%f '


# vi mode
bindkey -v
export KEYTIMEOUT=1


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

export SAVEHIST=0
export HISTFILE=0

. $ZDOTDIR/aliasrc && source $ZDOTDIR/aliasrc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/deebakkarthi/.local/share/conda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/deebakkarthi/.local/share/conda/etc/profile.d/conda.sh" ]; then
        . "/Users/deebakkarthi/.local/share/conda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/deebakkarthi/.local/share/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


eval "$(zoxide init zsh --cmd cd)"
