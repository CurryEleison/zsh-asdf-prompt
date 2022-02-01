
function asdf_prompt_info() {
  # If asdf isn't present nothing to do
  (( ${+commands[asdf]} )) || return 0
  local currenttools=$(asdf current)
  # Decide how we filter what is shown
  if [[ $ZSH_THEME_ASDF_PROMPT_FILTER != "ALL" ]]; then
    currenttools=$(echo $currenttools | grep -v ' system ' -)
  fi
  if [[ -z "${ZSH_THEME_ASDF_PROMPT_FILTER// }" \
      || $ZSH_THEME_ASDF_PROMPT_FILTER == "COMPACT" ]]; then
    currenttools=$(echo $currenttools | grep -v "$HOME/.tool-versions" -)
  fi

  # Decide if anything is left to process and return if not.
  [[ -z "${currenttools// }" ]] && return

  local toolslist=$(echo $currenttools | awk '{ print $1 }')
  local versionslist
  # Decide if we do semi-major version (default) or full version info
  if [[ $ZSH_THEME_ASDF_PROMPT_VERSION_DETAIL == "PATCH" ]]; then
    versionslist=$(echo $currenttools | awk '{ print $2 }' - )
  elif [[ $ZSH_THEME_ASDF_PROMPT_VERSION_DETAIL == "MAJOR" ]]; then
    versionslist=$(echo $currenttools | awk '{ print $2 }' - \
      | sed -E 's/([^\.]*)(\.[^\.]*)(\..*)/\1/g' - \
      | sed 's/system/s/g' -)
  else
    versionslist=$(echo $currenttools | awk '{ print $2 }' - \
      | sed -E 's/([^\.]*)(\.[^\.]*)(\..*)/\1\2/g' - \
      | sed 's/system/sys/g' -)
  fi
  # Decide if we want to print out origins or not (default)
  local originslist
  if [[ $ZSH_THEME_ASDF_PROMPT_VERSION_RESOLUTION == "COMPACT" ]]; then
    originslist=$(echo $currenttools | awk '{ print $3 }' \
      | sed -E 's#ASDF_.*VERSION#\$#' \
      | sed -E "s#$HOME\/*\.tool-versions#\~#" \
      | sed -E "s#$PWD\/*\.tool-versions#\.#" \
      | sed -E "s#($HOME\/.+)#\/#" )
  else
    originslist=$(echo $currenttools | awk '{ print ""}' -)
  fi
  # Paste columns together and scrunch up in a single line  
  local reassembled=$(paste  <(echo $toolslist) <(echo $versionslist) \
    <(echo $originslist))
  local asdfsummary=$(echo $reassembled \
    | awk '{ print $1 ": " $2 $3 }' - \
    | head -c -1 - \
    | sed ':a;N;$!ba;s/\n/, /' -)

  echo "${ZSH_THEME_ASDF_PROMPT_PREFIX-\{}"\
    "$asdfsummary${ZSH_THEME_ASDF_PROMPT_POSTFIX-\}}"
}

# Default values for the appearance of the prompt.
ZSH_THEME_ASDF_PROMPT_PREFIX="{"
ZSH_THEME_ASDF_PROMPT_POSTFIX="} "
ZSH_THEME_ASDF_PROMPT_FILTER="COMPACT"
ZSH_THEME_ASDF_PROMPT_VERSION_DETAIL="MINOR"
ZSH_THEME_ASDF_PROMPT_VERSION_RESOLUTION="NONE"
