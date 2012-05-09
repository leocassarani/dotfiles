# Leo Cassarani's Dotfiles

This repository contains a copy of my most important dotfiles. I don't expect them to be very useful to anyone other than myself, but you might be able to pick up the odd trick here and there. It goes without saying that by copying any of their contents you assume full responsibility for any consequences they may have on your system.

## Vim

I use Vim on top of [Janus](https://github.com/carlhuda/janus), a collection of plug-ins and settings that can be installed in minutes to get you up and running with a modern Vim setup.

Following Janus convention, my `.vimrc` file is split into `.vimrc.before` and `.vimrc.after`, with the bulk of my customisations going into the latter. There's also a `.gvimrc.after` file, which I don't actually use as I run Vim from Zsh running inside iTerm 2, but it contains a few useful settings that help in those rare cases that I have to use MacVim.

My Vim setup is heavily biased towards editing Ruby and Rails code. Quite a few of my functions come from Gary Bernhardt, and I also have Vim set up to automatically strip trailing whitespace whenever I write to a file, which I stole from a fellow [Unboxed](http://www.unboxedconsulting.com) employee.

## Git

Most of the contents of my `.gitconfig` file come from an earlier version of [Gary Bernhardt's](https://github.com/garybernhardt/dotfiles), and they mostly consist of a few very simple shortcuts that I couldn't live without. `git aa`, `git di` and `git dc` are probably my absolute favourites.

## Zsh

I use Zsh with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh), so there isn't much to see in my `.zshrc` file, as the bulk of my customisations come from `oh-my-zsh` plugins.
