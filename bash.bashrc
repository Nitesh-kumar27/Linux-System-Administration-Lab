# ===================================================================
# MODERN COMPACT BASH CONFIG
# ===================================================================

[[ $- != *i* ]] && return

# -------------------------------------------------------------------
# HISTORY
# -------------------------------------------------------------------
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
shopt -s checkwinsize
shopt -s autocd
shopt -s globstar

# -------------------------------------------------------------------
# COLORS
# -------------------------------------------------------------------
RESET="\[\e[0m\]"
RED="\[\e[31m\]"
GREEN="\[\e[32m\]"
YELLOW="\[\e[33m\]"
BLUE="\[\e[34m\]"
CYAN="\[\e[36m\]"
GRAY="\[\e[90m\]"

# -------------------------------------------------------------------
# FAST GIT STATUS
# -------------------------------------------------------------------
git_info() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch
    branch=$(git branch --show-current 2>/dev/null)

    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo " ${YELLOW}● ${branch}${RESET}"
    else
        echo " ${GREEN}✔ ${branch}${RESET}"
    fi
}

# -------------------------------------------------------------------
# PROMPT
# -------------------------------------------------------------------
build_prompt() {
    local EXIT_CODE=$?

    local STATUS="${GREEN}✔${RESET}"
    [[ $EXIT_CODE -ne 0 ]] && STATUS="${RED}✘${RESET}"

    local USER_COLOR="${CYAN}"
    [[ $EUID -eq 0 ]] && USER_COLOR="${RED}"

    local VENV=""
    [[ -n "$VIRTUAL_ENV" ]] && \
        VENV="${YELLOW}($(basename "$VIRTUAL_ENV"))${RESET} "

    PS1="${GRAY}[\A]${RESET} ${STATUS} ${USER_COLOR}\u${RESET}@${GRAY}\h${RESET} ${BLUE}\w${RESET}$(git_info) ${VENV}${GRAY}❯${RESET} "
}

PROMPT_COMMAND=build_prompt

# -------------------------------------------------------------------
# COLORS & LS
# -------------------------------------------------------------------
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b)"
fi

alias ls='ls --color=auto -h --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# -------------------------------------------------------------------
# FILE OPERATIONS
# -------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# -------------------------------------------------------------------
# NAVIGATION
# -------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# -------------------------------------------------------------------
# SAFETY
# -------------------------------------------------------------------
alias rm='rm -Iv'
alias cp='cp -iv'
alias mv='mv -iv'

# -------------------------------------------------------------------
# SYSTEM
# -------------------------------------------------------------------
alias reload='source ~/.bashrc'
alias cls='clear'
alias df='df -h'
alias free='free -h'
alias psa='ps auxf'
alias ports='ss -tulpen'
alias weather='curl wttr.in'
alias myip='curl -s ifconfig.me && echo'
alias localip='ip -4 addr show | grep inet'
alias sysupdate='sudo parrot-upgrade'

# -------------------------------------------------------------------
# EDITOR
# -------------------------------------------------------------------
export EDITOR=nano
export VISUAL=nano
