# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi

export PATH=$PATH:~/.local/bin/

#scripts
export PATH=$PATH:~/.config/scripts
export PATH=$PATH:~/.config/scripts/Dotfiles

# Path to your oh-my-zsh installation.
export ZSH="/home/joshua/.oh-my-zsh"
export EDITOR="nvim"
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
#
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
  npm
  zsh-interactive-cd
  z
  yarn
  ufw
  systemadmin
  pass
  minikube
  kubectl
  jsontools
  docker
  copybuffer
  copypath
  command-not-found
  transfer
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

source $ZSH/oh-my-zsh.sh

# Quick cd using fzf
fcd() {
  cd "$(find -type d | fzf)"
}

# Find and edit using fzf
fe() {
  nvim "$(find -type f | fzf)"
}

pe() {
  local file
  file=$(find ~/.password-store -type f -name '*.gpg' | sed "s|^$HOME/.password-store/||;s|\.gpg$||" | fzf)
  if [ -n "$file" ]; then
    pass edit "$file"
  fi
}

# Find and remove files with fzf
frm() {
  # Use `find` to list files and directories, and pipe them to `fzf` for selection
  selected=$(find . -type f -o -type d 2>/dev/null | fzf -m)
  
  # Check if any selection was made
  if [[ -n "$selected" ]]; then
    # Echo the files or directories that will be deleted
    echo "Deleting the following files or directories:"
    echo "$selected"
    
    # Use `xargs` to safely pass selected files/directories to `rm -rf`
    echo "$selected" | xargs -d '\n' rm -rf
  else
    echo "No files or directories selected."
  fi
}
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# autosuggestions
#source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# path for GO
export PATH="$PATH:$HOME/go/bin"

# Programs
alias cat="bat"
alias cl="clear"
alias ls="eza -l --icons"
alias la="eza -TL 2 --icons"
alias nb="newsboat"
alias lg="lazygit"
alias ld="lazydocker"
alias py="python"
alias td="termdown"

# Aliases 2024
alias dnf="sudo dnf"
# alias dnfupdate ="sudo dnf update && flatpak update"
alias p="sudo pacman"
alias ytd='yt-dlp'
alias src="source ~/.zshrc"
alias ezsh="nvim ~/.zshrc"

# Navigation
alias oo="cd ~/Vaults"
alias bills="nvim ~/Vaults/Personal/bills.md"
alias godir="cd ~/go/src"
alias blog="tmuxp load ~/Development/Blog2024/blogsession.yaml"
alias gop="tmuxp load ~/go/src/github.com/jblais493/EchoBoilerplate/echosession.yaml"
alias htmx="tmuxp load ~/go/src/github.com/jblais493/HTMXFrontend/configs/htmxsession.yaml"
alias login="tmuxp load ~/go/src/github.com/jblais493/go-login/gologin.yaml"
alias backend="tmuxp load ~/go/src/github.com/jblais493/hometrovabackend/hometrovabackend.yaml"
alias writing="tmuxp load ~/Vaults/Writing/writing.yaml"
alias dev="cd ~/Development"
alias photos="cd /mnt/nomad/TrueNAS/Photos"
alias f="thunar . &"
alias revere="cd /mnt/nomad/TrueNAS/Revere"
alias revereb="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage"
alias commer="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Deals/2024Commercial"
alias sellers="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Deals/2024/Sellers"
alias buyers="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Deals/2024/Buyers"
alias revsys="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Systems"
alias nas="cd /mnt/nomad/TrueNAS"
alias media="cd /mnt/nomad/TrueNAS/media"
alias music="cd ~/Music"
alias movies="cd /mnt/nomad/TrueNAS/media/Movies"
alias mountain="cd /mnt/nomad/TrueNAS/Writing/Books/Mountain"
alias library="cd /mnt/nomad/TrueNAS/Library"

# Scripts
alias eopn="~/.config/scripts/manage_encrypted_drives eopn"
alias ecls="~/.config/scripts/manage_encrypted_drives ecls"
alias rs="gammastep -O 1965K &"
alias rsx="killall gammastep"
alias pg="pass generate"
alias v="nvim"
alias sd="spotdl"
alias syncvault="rsync -avz --delete /mnt/TrueNAS/ /mnt/Vault/TrueNAS"
alias syncnas="rsync -avz --delete /mnt/nomad/TrueNAS/ /mnt/External4TB/TrueNAS"
alias mntnas="sshfs joshua@172.18.250.13:/mnt/Vault /mnt/Logos"
alias umountnas="fusermount -u /mnt/Logos"
alias mntexternal="sudo mount /dev/sdb1 /mnt/External4TB"
alias mntvault="sudo mount /dev/sda /mnt/Logos"
alias doomsync="~/.emacs.d/bin/doom sync"
alias doomrefresh="~/.emacs.d/bin/doom refresh"
alias reverecalc="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Systems/Programs/Calculators && python ConveyancingOutput.py"
alias buyercalc="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Systems/Programs/Calculators && python BuyerCommissionCalc.py"
alias record="arecord -f cd output.wav"
alias anime="~/.config/scripts/ani-cli/ani-cli"
alias brodirs="mkdir 'Brokerage Documents' 'Offer' 'Conveyancing' 'Payout' 'Posts'"
# alias newpost="gimp /mnt/TrueNAS/Revere/Revere\ LATEST/Marketing/POSTS/Templates/2022\ IG\ Template\ NEW\ LISTING.xcf"
# alias soldpost="gimp /mnt/TrueNAS/Revere/Revere\ LATEST/Marketing/POSTS/Templates/2022\ IG\ Template\ SOLD.xcf"
# alias openhouse="gimp /mnt/TrueNAS/Revere/Revere\ LATEST/Marketing/POSTS/Templates/2022\ IG\ Template\ OPEN\ HOUSE.xcf"
alias acct="libreoffice /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Accounting/2022/Revere\ Bookkeeping\ 2022.ods"
alias convey="nvim /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/CONVEYANCING/Information\ for\ Conveyancing/Lawyers/Lawyer\ Contact\ Information"
alias twit="gimp /mnt/Logos/TrueNAS/Personal/Twitter.xcf"
alias tw="cd ~/Development/SocialPosts && python tweet.py"
alias strip="mogrify -strip"

# Networking
alias nmconnect="nmcli device wifi connect"
alias nmdown="nmcli c delete"
alias nmlist="nmcli device wifi list"
alias nmdelete="nmcli device delete"
alias startvpn="sudo systemctl start wg-quick@wg0"
alias stopvpn="sudo systemctl stop wg-quick@wg0"

# Payouts
alias letterhead="cd /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Logos\ and\ Assets/Letterhead/2022/"
alias eftinfo="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Logos\ and\ Assets/Letterhead/2022/Paid\ by\ EFT.xcf"
alias invoice="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Logos\ and\ Assets/Letterhead/2022/Commission\ Invoice\ Template.xcf"
alias cashback="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Logos\ and\ Assets/Letterhead/2022/Cashback\ Template.xcf"
alias payout="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Systems/Templates/Invoicing\ Templates/Paystub\ Template.xcf"
alias payoutBobby="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Agents/Paystubs/Paystub\ -\ Bobby\ Kriangkum.xcf"
alias payoutCody="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Agents/Paystubs/Paystub\ -\ Cody\ Serediak.xcf"
alias payoutSeth="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Brokerage/Alberta/Edmonton/Agents/Paystubs/Paystub\ -\ Seth\ Macdonald.xcf"
alias cinst="gimp /mnt/nomad/TrueNAS/Revere/Revere\ LATEST/Systems/Conveyancing/Templates/Conveyancing\ Instructions\ Template.xcf"

# Tmux commands
alias kat="tmux kill-server"
alias t="TERM=screen-256color-bce tmux"
alias tat="tmux attach -t"
alias tsf="tmux source-file ~/.tmux.conf"
alias tk="tmux kill-session -a"

# config files
alias envim="cd ~/.config/nvim && nvim"
alias ehyp="cd ~/.config/hypr && nvim"
alias qutebrowser="cd ~/.config/qutebrowser"
alias shell="cd ~/.config/shell"
alias scripts="cd ~/.config/scripts"
alias books="cd ~/.config/scripts/bookmarks"

# Development
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dcb="docker compose build"
alias dc="docker compose"
alias tr="go-task run"
alias tb="go-task templ"
alias ttw="go-task tailwindcss"

bindkey -v
bindkey -M viins 'kj' vi-cmd-mode
# this will cd and ls at the same time.
function cd {
    builtin cd "$@" && ls -F
    }

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# (cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:~/.config/bspwm

eval $(thefuck --alias)
SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


function r() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

eval "$(starship init zsh)"
eval "$(tmuxifier init -)"
eval "$(zoxide init zsh)"
