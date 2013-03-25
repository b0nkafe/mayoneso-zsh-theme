mayoneso zsh theme
==================

This is my actual [OhMyZsh](https://github.com/robbyrussell/oh-my-zsh) theme, made from scratch.

The theme shows the next info:
* Colored user depending on UID (red for UID 0, yellow for everyone else)
* FQDN.
* Hour.
* PWD (%~).
* In my particular case, checks if a ppp interface exist and displays if it's up / down.
* Colorized load avgs.

Installation
------------
To install it just do this:
* Copy the theme file to `~/.oh-my-zsh/themes`
* Set `ZSH_THEME` to `mayoneso` on `~/.zshrc`

Screenshot
----------
![screenshot](https://raw.github.com/bheras/mayoneso-zsh-theme/master/img/mayoneso.png)

Notes
-----
If you run into issues with [OhMyZsh](https://github.com/robbyrussell/oh-my-zsh) plugins when _sudoing_, just add this to `/etc/sudoers`:

`Defaults    env_keep += "ZSH"`
