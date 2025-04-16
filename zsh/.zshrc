# Add ~.local/bin to path
export PATH="$HOME/.local/bin:$PATH"

# Set neovim as default text editor
export EDITOR="nvim"

# Ensure mise is installed, activated through zcomet
if [ ! -f $HOME/.local/bin/mise ]; then
  curl https://mise.run | sh
fi

# Set zcomet dir
ZCOMET_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zcomet"

# Ensure zcomet is installed
if [ ! -f "$ZCOMET_HOME/zcomet.zsh" ]; then
  mkdir -p "$(dirname $ZCOMET_HOME)"
  git clone https://github.com/agkozak/zcomet.git "$ZCOMET_HOME"
fi
source "$ZCOMET_HOME/zcomet.zsh"

# Enable ohmyzsh plugin support
export ZSH="$HOME/.zcomet"
export ZSH_CUSTOM="${ZSH}/custom"
export ZSH_CACHE_DIR="${ZSH}/cache"

# Include completions
fpath=( ~/.zcomet/cache/completions ~/.config/zsh/site-functions $fpath )

# Config plugins
ZOXIDE_CMD_OVERRIDE="cd"

# Load zsh plugins
zcomet load ohmyzsh plugins/mise
zcomet load ohmyzsh plugins/aliases
zcomet load ohmyzsh plugins/command-not-found
zcomet load ohmyzsh plugins/eza
zcomet load ohmyzsh plugins/fzf
zcomet load ohmyzsh plugins/gh
zcomet load ohmyzsh plugins/git
zcomet load ohmyzsh plugins/sudo
zcomet load ohmyzsh plugins/uv
zcomet load ohmyzsh plugins/zoxide
zcomet load Aloxaf/fzf-tab
zcomet fpath zsh-users/zsh-completions src
zcomet trigger --no-submodules archive unarchive lsarchive \
    sorin-ionescu/prezto modules/archive
zcomet trigger bd Tarrasch/zsh-bd
zcomet load ohmyzsh plugins/profiles
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet compinit

# Load oh-my-posh
if [ ! -f "$HOME/.local/bin/oh-my-posh" ]; then
  bash <(curl -s https://ohmyposh.dev/install.sh) -d ~/.local/bin -t ~/.cache/oh-my-posh/themes
fi
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/gentoo.yaml)"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Force emacs keybindings
bindkey -e

# Completions and env imports
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -TL2 --color=always $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Aliases
alias zcfg="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim/init.lua"
alias vim="nvim"
alias yt="yt-dlp"
alias yta="yt-dlp -x"
alias flatup="flatpak upgrade"
alias flatin="flatpak install"
alias flatun="flatpak uninstall"
alias omp="oh-my-posh"
alias ompup="bash <(curl -s https://ohmyposh.dev/install.sh) -d ~/.local/bin -t ~/.cache/oh-my-posh/themes"
alias incognito="unset HISTFILE"
alias lz="la -Z"
command -v bat &> /dev/null && alias cat="bat"
command -v batman &> /dev/null && alias man="batman"

# Complex aliases
function dict() {
  command dict "$@" | less -R
}

function cheat() {
  curl -s https://cht.sh/"$@" | less -R
}

function weather() {
  curl https://wttr.in/"$@"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}

function ranger() {
  local tmp="$(mktemp -t "ranger-cwd.XXXXXX")"
  command ranger "$@" --choosedir="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd "$cwd"
  fi
  rm -f -- "$tmp"
}

# Ensure tpm is installed
if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# Remove pipenv in venv warnings
export PIPENV_VERBOSITY=-1
export PIPENV_VENV_IN_PROJECT=1

# Use kitten for ssh in kitty
if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh="kitten ssh"
  alias icat="kitten icat"
  alias diff="kitten diff"
  alias clip="kitten clipboard"
fi

update() {
  command -v apt &> /dev/null && sudo apt update && sudo apt upgrade
  command -v dnf &> /dev/null && sudo dnf upgrade
  command -v flatpak &> /dev/null && flatpak update
  command -v mise &> /dev/null && mise self-update && mise up
  command -v cargo-install-update &> /dev/null && cargo install-update -a
}

# Configure fzf
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--layout reverse --style minimal --no-height"
export FZF_CTRL_T_OPTS="--walker-skip .git --preview 'fzf-preview.sh {}'"
export FZF_ALT_C_OPTS="--preview 'eza -TL2 --color=always {}'"
export FZF_COMPLETION_DIR_OPTS="--walker dir,follow"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)  fzf --preview "eza -TL2 --color=always {}" "$@" ;;
    ssh) fzf --preview "dig {}"                     "$@" ;;
    *)   fzf --preview "fzf-preview.sh {}"          "$@" ;;
  esac
}

# bitwarden-cli aliases
bwunlock() {
  export BW_SESSION=$(bw unlock --raw)
}

alias bwlock="unset BW_SESSION"
