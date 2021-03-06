# asdf-prompt plugin for zsh/oh-my-zsh

A `zsh` prompt for `asdf` users that displays information about your current tool versions.

## Examples

The plugin will by default stay quiet when asdf tool versions are at your global settings.

If you are in a folder affected by a `.tool-versions` file or have set a `$ASDF_*_VERSION` 
it will list the changed versions. Here, I have tweaked versions of python and nodejs:  
[![Screenshot #1.1](images/nodejs-python-default.png)](images/nodejs-python-default.png)

You can embellish with details on versions and version resolution with the `$ZSH_THEME_ASDF_PROMPT_*` environment variables:  
[![Screenshot #1.2](images/nodejs-python-detailed.png)](images/nodejs-python-detailed.png)  
See section on environment variables further down to learn about the options.

## Requirements

Currently only really tested with `oh-my-zsh`.

## Install

Run
```zsh
git clone https://github.com/CurryEleison/zsh-asdf-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-asdf-prompt
```

to install the plugin into your `custom folder`. Activate the plugin in `~/.zshrc`:

```zsh
plugins=( [plugins...] zsh-asdf-prompt)
```

Add the prompt info in your theme with `$(asdf_prompt_info)`. E.g.
```zsh
PROMPT='%n@%m $(asdf_prompt_info)${(s:/:)PWD/#$HOME/~}%(!.#.>) '
ZSH_THEME_ASDF_PROMPT_PREFIX="%{$fg_bold[magenta]%}{"
ZSH_THEME_ASDF_PROMPT_POSTFIX="}%{$reset_color%} "
ZSH_THEME_ASDF_PROMPT_VERSION_RESOLUTION="COMPACT"
```

## Environment variables in use
- `ZSH_THEME_ASDF_PROMPT_PREFIX`: Prompt prefix. Default to {
- `ZSH_THEME_ASDF_PROMPT_POSTFIX`: Prompt postfix. Default to }
- `ZSH_THEME_ASDF_PROMPT_FILTER`: Tools to show in prompt. `COMPACT`, `USER` or `ALL`. Default to `COMPACT`
    - `ALL` shows all asdf tools 
    - `USER` shows all that are not using `system` version
    - `COMPACT` shows tools that are not system and not the default version for the user as defined by `~/.tool-versions`
- `ZSH_THEME_ASDF_PROMPT_VERSION_DETAIL`: Version detail. `MINOR`, `MAJOR` or `PATCH`
    - `MINOR`: Show major + minor version. Like "python: 3.10, nodejs: 17.4"
    - `MAJOR`: Show major version. Like "python: 3, nodejs: 17"
    - `PATCH`: Include patch version. Like "python: 3.10.1, nodejs: 17.4.0"
- `ZSH_THEME_ASDF_PROMPT_VERSION_RESOLUTION`: Show how version was resolved. `COMPACT` or `NONE`. Default is `NONE`
    - `NONE`: Omit version resolution info
    - `COMPACT`: Show how `asdf`resolved versions
        - "$" is from `ASDF_<TOOLNAME>_VERSION` environment variables
        - "~" from `.tool-versions` in home dir
        - "." from `.tool-versions` in current dir
        - "/" from `.tool-versions` in other parent dir
