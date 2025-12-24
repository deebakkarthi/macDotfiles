#!/bin/zsh

autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache 1
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

export SAVEHIST=0
export HISTFILE=0

. $ZDOTDIR/aliasrc && source $ZDOTDIR/aliasrc

eval "$(zoxide init zsh --cmd cd)"
