# Straightforward theme with username, PWD, git status, and timestamp.
# Made by diegospinax_ :D

hex_to_rgb() {
  local hex=$1
  echo "%{\e[38;2;$((16#${hex:0:2}));$((16#${hex:2:2}));$((16#${hex:4:2}))m%}"
}

# Directory info.
local current_dir='%2~'

GIT_PREFIX="$(hex_to_rgb "DDB15F")git(%{$reset_color%}"
GIT_END="$(hex_to_rgb "DDB15F"))%{$reset_color%}"

# VCS
YS_VCS_PROMPT_PREFIX="$(hex_to_rgb "D4AAFC")\ue725 "
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✘"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${GIT_PREFIX}$YS_VCS_PROMPT_PREFIX"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="${GIT_END}$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="${GIT_END}$YS_VCS_PROMPT_CLEAN"

ARROW=$'\u279c'

# Prompt
PROMPT="
$(hex_to_rgb "E36464")@%n \
$(hex_to_rgb "5CACEE")${ARROW}%{$reset_color%} \
$(hex_to_rgb "D3D3D3")${current_dir}%{$reset_color%} \
${git_info}\
%{$fg[white]%}
$(hex_to_rgb "DCB977")$ %{$reset_color%}"
