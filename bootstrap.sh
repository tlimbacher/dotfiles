#!/bin/bash
# ------------------------------------------------------------------------------------------------------------
# This script installs oh-my-zsh, creates a conda environment for neovim, and creates symlinks from the home
# directory to any desired dotfiles in ~/.dotfiles.
# ------------------------------------------------------------------------------------------------------------

# Variables
# ------------------------------------------------------------------------------------------------------------
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
OLD_DOTFILES_DIR=~/.dotfiles_old
NVIM_DATA_DIR=~/.local/share
NVIM_CONFIG_DIR=~/.config/nvim
OH_MY_ZSH_DIR=~/.oh-my-zsh
OH_MY_ZSH_THEME_DIR=~/.oh-my-zsh/custom/themes

NVIM_FILES="nvim"
NVIM_CONFIG="init.vim"
ZSH_THEME="nord.zsh-theme"
NEOVIM_ENVIRONMENT="neovim.yml"
CONFIG_FILES="aliases bash_profile bashrc condarc flake8 gitconfig gitignore_global pydocstring screen_layout"
CONFIG_FILES="$CONFIG_FILES screenrc zshrc"


# Pull the latest changes.
# ------------------------------------------------------------------------------------------------------------
git pull origin IGI


# Install oh-my-zsh.
# ------------------------------------------------------------------------------------------------------------
if [ ! -d $OH_MY_ZSH_DIR ]; then
    echo "Installing oh-my-zsh in $OH_MY_ZSH_DIR ..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
        "" --unattended
    echo "done"
fi


# Create OLD_DOTFILES_DIR directory.
# ------------------------------------------------------------------------------------------------------------
echo "Creating $OLD_DOTFILES_DIR for backup of any existing dotfiles ..."
mkdir -p $OLD_DOTFILES_DIR
echo "done"


# Change to the DOTFILES_DIR directory.
# ------------------------------------------------------------------------------------------------------------
echo "Changing to the $DOTFILES_DIR directory ..."
cd $DOTFILES_DIR
echo "done"


# Move any existing dotfiles to OLD_DOTFILES_DIR directory.
# ------------------------------------------------------------------------------------------------------------
echo "Moving any existing dotfiles to $OLD_DOTFILES_DIR directory ..."
for file in $CONFIG_FILES; do
    if [ -e ~/.$file ]; then
        mv ~/.$file $OLD_DOTFILES_DIR/
    fi
done
if [ -d $NVIM_DATA_DIR/$NVIM_FILES ]; then
    mv $NVIM_DATA_DIR/$NVIM_FILES $OLD_DOTFILES_DIR/
fi
if [ -f $NVIM_CONFIG_DIR/$NVIM_CONFIG ]; then
    mv $NVIM_CONFIG_DIR/$NVIM_CONFIG $OLD_DOTFILES_DIR/
fi
if [ -f $OH_MY_ZSH_THEME_DIR/$ZSH_THEME ]; then
    mv $OH_MY_ZSH_THEME_DIR/$ZSH_THEME $OLD_DOTFILES_DIR/
fi
if [ -f ~/.NERDTreeBookmarks ]; then
    mv ~/.NERDTreeBookmarks $OLD_DOTFILES_DIR/
fi
echo "done"


# Create symlinks to any files in the ~/.dotfiles directory.
# ------------------------------------------------------------------------------------------------------------
echo "Creating symlinks in $HOME directory ..."
for file in $CONFIG_FILES; do
    ln -s $DOTFILES_DIR/$file ~/.$file
done
ln -s $DOTFILES_DIR/$NVIM_FILES $NVIM_DATA_DIR
mkdir -p $NVIM_CONFIG_DIR
ln -s $DOTFILES_DIR/$NVIM_CONFIG $NVIM_CONFIG_DIR/

if [ -d "$OH_MY_ZSH_THEME_DIR" ]; then
	ln -s $DOTFILES_DIR/$ZSH_THEME $OH_MY_ZSH_THEME_DIR/$ZSH_THEME
fi
echo "done"


# Create NERDTreeBookmarks file.
# ------------------------------------------------------------------------------------------------------------
touch $HOME/.NERDTreeBookmarks
echo "HOME $HOME" >> $HOME/.NERDTreeBookmarks
if [ -d "$CALC" ]; then
    echo "Calc $CALC" >> $HOME/.NERDTreeBookmarks
fi
if [ -d "$HOME/Documents/Projects" ]; then
    echo "Projects $HOME/Documents/Projects" >> $HOME/.NERDTreeBookmarks
fi
if [ -d "$HOME/Documents/Teaching" ]; then
    echo "Teaching $HOME/Documents/Teaching" >> $HOME/.NERDTreeBookmarks
fi

# Source ~/.bash_profile
# ------------------------------------------------------------------------------------------------------------
source $HOME/.bash_profile


# Create neovim conda environment.
# ------------------------------------------------------------------------------------------------------------
if type conda &> /dev/null; then
    echo "Creating conda environment for neovim ..."
    conda env update --file $NEOVIM_ENVIRONMENT
    echo "done"
else
    echo "Conda not installed. Neovim wont work properly. Install required packages manually"
fi

# Start zsh
# ------------------------------------------------------------------------------------------------------------
if type zsh &> /dev/null; then
    exec zsh
fi
