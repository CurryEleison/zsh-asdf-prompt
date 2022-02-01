# asdf-prompt plugin for zsh/oh-my-zsh

A `zsh` prompt for `asdf` users that displays information about your current tool versions.

## Examples

TODO

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
    - `COMPACT`: Show how version was resolved by `asdf`
        - "$" is from environment variables
        - "~" from `.tool-versions` in home dir
        - "." from `.tool-versions` in current dir
        - "/" from `.tool-versions` in parent dir
