# Add ~.local/bin to path
export PATH=/home/rodrigo/.local/bin:$PATH

# Set neovim as default text editor
export EDITOR="nvim"

# Set zinit dir
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Load zsh plugins
zinit wait lucid light-mode for \
  Aloxaf/fzf-tab \
  zsh-users/zsh-syntax-highlighting \
  Tarrasch/zsh-bd \
  OMZP::colored-man-pages \
  OMZP::command-not-found \
  OMZP::sudo \
  OMZP::eza \
  OMZP::git \
  _local/omp-completions \
  _local/pipx-completions \
  as"completion" \
    OMZP::docker/completions/_docker \
  atinit"zicompinit; zicdreplay" \
    zsh-users/zsh-completions \
    OMZP::docker-compose \
    OMZP::docker \
  atload'_zsh_autosuggest_start' \
    zsh-users/zsh-autosuggestions

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

# Ensure mise is installed
if ! command -v mise &> /dev/null; then
  curl https://mise.jdx.dev/mise-latest-linux-x64 > ~/.local/bin/mise
  chmod +x ~/.local/bin/mise
fi
eval "$(~/.local/bin/mise activate zsh)"

# Source cargo
CARGOENV=$HOME/.cargo/env
if [ ! -f "$CARGOENV" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
source $CARGOENV

# Ensure cargo-binstall present
if ! command -v cargo-binstall &> /dev/null; then
  cargo install cargo-binstall
fi

# Source pipx completions
# autoload -U bashcompinit
# bashcompinit
# eval "$(register-python-argcomplete pipx)"

# Zoxide setup
if ! command -v zoxide &> /dev/null; then
  cargo-binstall zoxide -y
fi
source <(zoxide init zsh --cmd cd)

# FZF setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# yazi
if ! command -v yazi &> /dev/null; then
  cargo-binstall yazi-fm yazi-cli -y
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}

# Other tools
if ! command -v dust &> /dev/null; then
  cargo-binstall du-dust -y
fi

if ! command -v eza &> /dev/null; then
  cargo-binstall eza -y
fi
