# User configuration
# ------------------------------------------------------------------------------------------------------------

# Enable 256-color support
export TERM="xterm-256color"

test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# Local executables
export PATH="$HOME/.local/bin:$PATH"

# Users calc drive
export CALC="/calc/$USER"

# Latex
export TEXMFHOME="$HOME/.texmf"
export TEXMFCONFIG="$HOME/.texmf-config"

# Custom python modules
if [ -d "$CALC" ]; then
    export PYTHONPATH="$CALC/.opt/lib/python/utils:$PYTHONPATH"
    export PYTHONPATH="$CALC/.opt/lib/python/spaghetti:$PYTHONPATH"
fi

# Source ~/.extra if it exists
EXTRA=$HOME/.extra
if [ -f "$EXTRA" ]; then
    source "$EXTRA"
fi

# Personal aliases
source $HOME/.aliases


# Start Zsh for an interactive shell (if zsh exists), else setup Conda for bash.
# ------------------------------------------------------------------------------------------------------------
if [[ ($- == *i*) ]] && type zsh &> /dev/null; then
    export SHELL=$(which zsh)
    [ -z "$ZSH_VERSION" ] && exec "$SHELL"
else
    __conda_setup="$("$HOME/.miniconda3/bin/conda" "shell.bash" "hook" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/.miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/.miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/.miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi
