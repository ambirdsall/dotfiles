__zrc_log () {
    [ -n "$VERBOSE_ZSH_CONFIG" ] && printf "$1" || true
}
__zrc_logn () {
    # the "n" stands for "newline"
    __zrc_log "$1\n"
}

for conf in ~/.config/zsh/*.zsh; do
    __zrc_log "sourcing $(basename $conf)... "
    source "$conf"
    __zrc_logn "✅"
done

# Conditional configs, or: why evaluate a config file if it's not relevant to the actual
# tty context running the shell?

if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
    __zrc_log "sourcing maybe/wezterm.zsh... "
    source ~/.config/zsh/maybe/wezterm.zsh
    __zrc_logn "🦄"
fi

# TODO clean this up to its own file
if command -v wezterm > /dev/null; then
    wez-the-term () {
    if [ $# -eq 0 ]; then
        local workspace=$(find ~/.config/wezterm/workspaces -type f -exec basename {} \; | fzf)
    else
        local workspace=$1
    fi

    if [ -z "$workspace" ]; then
        return
    elif [ ! -f ~/.config/wezterm/workspaces/$workspace ]; then
        echo "Workspace $workspace not found" &>2
        echo "Available workspaces:\n$(find ~/.config/wezterm/workspaces -type f -exec basename {} \;)" &>2
        return 1
    fi

    wezterm start --workspace $workspace ~/.config/wezterm/workspaces/$workspace
    }

    _wez_the_term_completion() {
    local -a workspaces
    workspaces=($(find ~/.config/wezterm/workspaces -type f -exec basename {} \;))
    _describe 'workspaces' workspaces
    }

    compdef _wez_the_term_completion wez-the-term
fi

again () {
    clear && VERBOSE_ZSH_CONFIG=t zsh
}

list_sessions_if_inside_tmux

# TODO because most aliases got moved into ~/.config/zsh/**, with
# ~/aliases.zsh serving as easy entry point for re-sourcing, most of these
# are getting double-sourced (with the exception of ~/.local-aliases.zsh)
[[ -a ~/aliases.zsh ]] && source ~/aliases.zsh
[ -f ~/.local-aliases.zsh ] && source ~/.local-aliases.zsh

# this should always go last, to allow local overrides of anything
if [[ -a ~/.zshrc.local.zsh ]]; then
    __zrc_log "sourcing ~/.zshrc.local.zsh... "
    source ~/.zshrc.local.zsh
    __zrc_logn "🔥"
fi
