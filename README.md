# BMDotfiles
These are my dotfiles. There are many like them, but these ones are mine.

## Installing

Tl;dr:
```sh
git clone https://github.com/bmd/dotfiles.git && \
    cd dotfiles && \
    make install
```

<kbd>make install</kbd> will bootstrap homebrew and Oh-my-zsh!, install brewed and casked dependencies, and set up symlinks for all of the files in `./dotfiles` to `~`. Subsequently, you can just run <kbd>make
update</kbd> to pull the latest version of the files and refresh the symlinks.

## What's in the box? WHAT'S IN THE BOX??

<kbd>Brewfile</kbd> Homebrew packages for development dependencies, as well as casks to install binaries for other software I depend on. Running `make install` will also run `brew bundle install` as part of the setup.

<kbd>Makefile</kbd> Wrapper commands for running and managing this repo (metascript, not part of the host system's configuration)

<kbd>dotfiles/</kbd> The source of truth for all my system configs. For the time being, everything in `./dotfiles` is symlinked directly into `~`, but I might do something more complex in the future.
 - <kbd>.1password.zsh</kbd>
 - <kbd>.aliases.zsh</kbd>
 - <kbd>.

## My terminal and prompt

I get a lot of questions from people when they see my terminal for the first time. There's a lot going on between the terminal, shell, and prompt (each of which I have pretty heavily customized as part of this environment).

**Terminal**: Hyper (formerly HyperTerm). I used iTerm2 up until recently, but eventually I got on the Hype-train with Hyper. Hyper is an Electron-based terminal, which means that it can be fully scripted with Javascript.

**Shell**: Zsh + Oh-my-Zsh!

**Prompt**: Spaceship prompt

**Aliases**: Some developers tend to have a lot of custom aliases that develop into an almost-unique shell dialect known only to them. I actively try to avoid this; saving shell keystrokes never saves as much time as you think it does. But, there are a few aliases I think are very useful and not too much of a stretch from existing idioms.

<kbd>alias ll="ls -lah"</kbd> Cryptic, but this one is absolutely worth the time to avoid typing those extra flags.

<kbd>alias ops=""<kbd>

<kbd>alias vsco="code ."</kbd>
