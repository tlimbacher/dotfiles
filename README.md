# Thomas's dotfiles

## Installation
The `bootstrap.sh` script will save a copy of your existing dotfiles in `~/.dotfiles_old`. However, if you
want to give these dotfiles a try, you should first review the code and remove things you don’t want or need.

The script will install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and will create a
[conda](https://docs.conda.io/en/latest/) environment for [neovim](https://github.com/neovim/neovim) if conda
is installed. If you do not use conda you have to install the required packages manually in order to use
neovim. (see [neovim.yml](https://github.com/tlimbacher/dotfiles/blob/master/neovim.yml)). For a list of
(neo)vim plugins have a look at my [init.vim](https://github.com/tlimbacher/dotfiles/blob/master/init.vim).

For conda, it is assumed that you have set up miniconda under `~/.miniconda3`.

At the first time you open neovim after the installation you have to do a `:PlugInstall` followed by a
`:UpdateRemotePlugins`. This will install and register all vim plugins defined in my
[init.vim](https://github.com/tlimbacher/dotfiles/blob/master/init.vim).

### Using Git and the bootstrap script
You can clone the repository wherever you want (I like to keep it in `~/.dotfiles`). The bootstrapper script
will pull in the latest version and create symlinks from the home directory to any dotfiles in `~/.dotfiles`.

```bash
git clone https://github.com/tlimbacher/dotfiles.git ~./dotfiles && cd ~/.dotfiles && ./bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
./bootstrap.sh
```

Alternatively, to update while avoiding that the conda environment is being updated:

```bash
git pull origin master
```

### Add custom commands
If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom
commands or to add commands you don't want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
GIT_AUTHOR_NAME="Thomas Limbacher"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="user@domain.com"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Feedback

Suggestions/improvements [welcome](https://github.com/tlimbacher/dotfiles/issues)!
