# Add latest wine-staging-tkg to path

source $HOME/.config/user-dirs.dirs

# Add ~.local/bin to path
export PATH=/home/rodrigo/.local/bin:$PATH

# Set neovim as default text editor
export EDITOR="nvim"

# Source cargo
CARGOENV=$HOME/.cargo/env
if [ ! -f "$CARGOENV" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
source $CARGOENV

# Ensure mise is installed
if ! command -v mise &> /dev/null; then
  curl https://mise.jdx.dev/mise-latest-linux-x64 > ~/.local/bin/mise
  chmod +x ~/.local/bin/mise
fi
eval "$(mise activate zsh)"

# Include local completions
fpath=( ~/.config/zsh/site-functions $fpath)

# Set zcomet dir
ZCOMET_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zcomet"

if [ ! -f "$ZCOMET_HOME/zcomet.zsh" ]; then
  mkdir -p "$(dirname $ZCOMET_HOME)"
  git clone https://github.com/agkozak/zcomet.git "$ZCOMET_HOME"
fi

source "$ZCOMET_HOME/zcomet.zsh"

# Load zsh plugins
zcomet load Aloxaf/fzf-tab
zcomet load ohmyzsh plugins/command-not-found
zcomet load ohmyzsh plugins/sudo
zcomet load ohmyzsh plugins/eza
zcomet load ohmyzsh plugins/git
zcomet load ohmyzsh plugins/dnf
zcomet load ohmyzsh plugins/fzf
zcomet load ohmyzsh plugins/docker-compose
zcomet fpath zsh-users/zsh-completions src
zcomet trigger --no-submodules archive unarchive lsarchive \
    sorin-ionescu/prezto modules/archive
zcomet trigger bd Tarrasch/zsh-bd
zcomet load zsh-users/zsh-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions
zcomet compinit

# Load oh-my-posh
if ! command -v oh-my-posh &> /dev/null; then
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
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Alias
alias bp="vim ~/.zshrc"
alias sa='source ~/.zshrc; echo ".zshrc reloaded"'
alias vimrc="vim ~/.config/nvim/init.lua"
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

command -v zoxide &> /dev/null && source <(zoxide init zsh --cmd cd)

# Use fd with fzf
export FZF_DEFAULT_COMMAND="fd --type file --hidden --exclude .git --color=always"
export FZF_DEFAULT_OPTS="--ansi"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

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
fi

update() {
  command -v apt &> /dev/null && sudo apt update && sudo apt upgrade
  command -v dnf &> /dev/null && sudo dnf upgrade
  command -v flatpak &> /dev/null && flatpak update
  command -v mise &> /dev/null && mise self-update && mise up
  command -v cargo-install-update &> /dev/null && cargo install-update -a
}

eval "$(register-python-argcomplete /usr/lib/python3.13/site-packages/legion_linux/legion_cli.py)"
