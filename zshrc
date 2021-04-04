export KUBECONFIG=~/.kube/config:~/.kube/config-AKS 
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR="nvim";
export FZF_DEFAULT_COMMAND="find -L"

# Only suggest corrections for commands, not arguments
setopt CORRECT
unsetopt CORRECTALL

##Keybinding za ctrl+a,del,home...
bindkey  "^[[H"   beginning-of-line    
bindkey  "^[[F"   end-of-line    
bindkey  "^[[3~"  delete-char    
bindkey "^A" vi-beginning-of-line    
bindkey "^E" end-of-line

# Created by newuser for 5.8
source ~/powerlevel10k/powerlevel10k.zsh-theme

###Novi path za moje skripte    
path+=('/home/nikola/skripte/sistemske')    
path+=('/home/nikola/skripte')    
export PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X compinit && compinit
source <(helm completion zsh)
source <(kubectl completion zsh)
source <(kompose completion zsh)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh                                                                                       
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/autojump/autojump.zsh

#Azure CLI
source /etc/bash_completion.d/azure-cli
#ZSH Syntax highlighting styling
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#a3a3a3"

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nikola/.zshrc'

##29/01/2021 promena autocompinit
autoload -U +X bashcompinit && bashcompinit
#autoload -Uz compinit
compinit
# End of lines added by compinstall
zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(
      zsh-autosuggestions
	  tmux
      auto-notify $plugins
)

###Fuzzy Find History###
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null ||
                        cat {} || tree -C {}) 2> /dev/null | head -200'"
#complete -o zshdefault -o default -F _fzf_path_completion zathura

##ssh-agent startup###
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

#aws-cli autocompletion
autoload bashcompinit && bashcompinit

complete -C '/usr/bin/aws_completer' aws

##System aliases##
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '

alias grep='grep --color=auto'
alias ip="ip -color=auto"
alias diff='diff --color=auto'

####Aliases######
alias suseserver="ssh nikola@suseserver -p 9123"
alias posasvisemon="xfreerdp /floatbar /dynamic-resolution /multimon /d:CORP /u:nk250172 /v:WRSNK250172-4GH:3389 /audio-mode:1 /gfx-h264 +fonts +aero +window-drag +nego +home-drive +cli  pboard"
alias posadvamonitora="xfreerdp /floatbar /dynamic-resolution /multimon /monitors:0,2 /d:CORP /u:nk250172 /v:WRSNK250172-4GH:3389 /audio-mode:1 /gfx-h264 +fonts +aero +window-drag +nego   +home-drive +clipboard"
alias posa="xfreerdp /floatbar /dynamic-resolution /d:CORP /u:nk250172 /v:WRSNK250172-4GH:3389 /audio-mode:1 /gfx-h264 +fonts +aero +window-drag +nego +home-drive +clipboard"
alias wolposo="wol 30:24:32:62:D0:2C"
alias woltanja="wol 70:4D:7B:63:05:B7"
alias publicIP="curl icanhazip.com"
alias completeBackup="sudo dd if=/dev/sda | gzip -1 - | ssh nikola@192.168.2.3 -p 9123 dd of=/media/nikola/toshiba2tb/arch_`date '+%Y_%m_%d__%H_%M_%S'`.gz status=progress"
alias ls="ls -ahN --color=auto --group-directories-first"
alias mpsytcache="rm ~/.config/mps-youtube/cache_py*"
alias todo="todo.sh"
alias tl="task list"
alias ta="task add"
alias ts="task start"
alias tstop="task stop"
alias tah="task add priority:H"
alias tam="task add priority:M"
alias tal="task add priority:L"
alias td="task done"
alias trm="task rm"
alias v="nvim"
alias vim="nvim"
alias sudo="sudo "
alias archNikola="ssh archNikola -p 9123"
#alias backupuToArchssh="sudo rsync -aAXv -e ssh / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} nikola@192.168.2.3:/media/nikola/toshiba2tb/ArchrsyncBackupssh -p 9123"
#alias backupuToArch="sudo rsync -aAXv / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /media/nikola/toshiba2tb/ArchsyncBackup"

alias dotfiles='/usr/bin/git --git-dir=/home/nikola/.dotfiles/ --work-tree=/home/nikola'
