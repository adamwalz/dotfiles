# Adam's Dot Files

These configuration files set up my command line interface.

## Environment

I hack on Mac OS X and changes will be necessary for Linux users, however I am currently attempting to make these dotfiles cross-platform. Send me pull requests with any changes in this regard.

Installation
============

Clone this repository into *~/.dotfiles*, change directory into _~/.dotfiles_, and execute the `rake install` task.

(1.) Launch [Zsh][1]:

```sh
    zsh
```

(2.) Clone the repository

```sh
    git clone git://github.com/adamwalz/dotfiles.git ~/.dotfiles
```

(3.) Set Zsh as your default shell

```sh
    chsh -s /bin/zsh
```

(4.) Rake install

```sh
    cd ~/.dotfiles
    rake install
```

Rake will **never** replace existing files but back them up into *~/.dotfiles_backup*. The dot files will be symbolically linked into the home directory. Templates will be rendered in place then symbolically linked. Since the *Rakefile* is currently Mac OS X specific, it must be edited for use with key chains on other operating systems. I welcome pull requests that add support for additional password managers.

Whats included
===============
* Zsh configurations (*zshrc*, *zpreztorc*, *zshenv*, *zlogin*)
* *dir_colors* for gnu terminal coloring
* git global configurations (*gitconfig*, *gitignore*)
* *pianobar* pandora terminal client
* *netrc.rrc* for FTP defaults
* *Rakefile* to install it all

Usage
======

## Prezto Zsh configuration framework

![sorin theme][2]

Zsh configuration is done useing the [Prezto][3] framework, originally a fork of
[oh-my-zsh][4]. Personal styles are changed in *zpreztorc*

  1. For a list of themes, type `prompt -l`.
  2. To preview a theme, type `prompt -p name`.
  3. Load the theme you like in *~/.zpreztorc* then open a new Zsh terminal
     window or tab.

In the sorin theme shown above, the following symbols show vim, git, and working
directory status.

### Left Prompt

- prezto — The current working directory.
- git:master:merge — Git branch and state.
- ❯❯❯ — Prompt: type after this.

### Right Prompt

- V — Vim command mode indicator.
- ⏎  — Non-zero return.
- ✚ — Git added.
- ⬆ - Git ahead.
- ⬇ - Git behind.
- ✖ — Git deleted.
- ✱ — Git modified.
- ➜ — Git renamed.
- ✭ - Git stashed.
- ═ — Git non-merged.
- ◼ — Git untracked.

## Authentication

Some programs require that authentication information is stored in their respective dot files. Instead of managing two separate dot file repositories, one for actual use and another sanitised for sharing, I store authentication information in the Mac OS X Keychain. In this case, the dot files will be generated from files of the same name that end in the **.rrc** extension, which are Ruby ERB templates.

The **.rrc** extension, which stands for raw dot file (runcom), is used instead of **.erb** to not conflict with non dot file ERB templates.

The .rrc syntax is `<%= Keychain['Entry Name'].account %>` and `<%= Keychain['Entry Name'].password %>` respectively. For example, this is a .netrc snippet.

```erb
login <%= Keychain['ftp_host'].account %>
password <%= Keychain['ftp_host'].password %>
```

The disadvantage of this method is that the dot files cannot be installed via SSH because Mac OS X disallows Keychain access.

## Terminals

[iTerm2.app][5] has mouse support. If you favour in continuing to use [Terminal.app][6], which does not have mouse support under Mac OS X 10.7 Lion, there are hacks available to improve it. Install [SIMBL][7] then install under _~/Library/Application Support/SIMBL/Plugins_ the following plugins.

- [MouseTerm.bundle][8] to enable mouse.
- [BounceTerm.bundle][9] to bounce the Dock when the terminal beeps.

Feedback
========

Suggestions/improvements
[welcome](https://github.com/adamwalz/dotfiles/issues)!

## Thanks to…

* [Sorin Ionescu](http://github.com/sorin-ionescu/dot-files) who started this journey for me. He also is the creator of [Prezto][3]
* [Mathias Bynens](http://github.com/mathiasbynens/dotfiles) for his immense list of OS X terminal configurations
* anyone who [contributed a patch](https://github.com/adamwalz/dotfiles/contributors) or [made a helpful suggestion](https://github.com/adamwalz/dotfiles/issues)

[1]: http://www.zsh.org
[2]: http://i.imgur.com/nBEEZ.png "sorin theme"
[3]: http://github.com/sorin-ionescu/prezto
[4]: https://github.com/robbyrussell/oh-my-zsh
[5]: http://www.iterm2.com
[6]: http://en.wikipedia.org/wiki/Apple_Terminal
[7]: http://www.culater.net/software/SIMBL/SIMBL.php
[8]: http://bitheap.org/mouseterm/
[9]: http://bitheap.org/bounceterm/
