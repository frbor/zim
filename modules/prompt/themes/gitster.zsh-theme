#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

#gst_get_status() {
#  print "%(?::%F{9}! %s)"
#}
prompt_gitster_status() {
  print -n '%(?:%F{green}:%F{red})➜ '
}

prompt_gitster_pwd() {
  prompt_short_dir=$(short_pwd)
  git_root=$(command git rev-parse --show-toplevel 2> /dev/null) && prompt_short_dir=${prompt_short_dir#${$(short_pwd $git_root):h}/}
  print -n "%F{white}${prompt_short_dir}"
}

prompt_gitster_git() {
  [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_context() {
  #if [[ ${USER} != ${DEFAULT_USER} || -n ${SSH_CONNECTION} ]]; then
  if [[ -n ${SSH_CONNECTION} ]]; then
    print "%F{cyan}%(!.%{%F{blue}%}.)%m "
    #print " %F{cyan}%(!.%{%F{blue}%}.)${USER}@%m"
  fi
}

prompt_gitster_precmd() {
  PROMPT='$(prompt_context)%F{green}$(gst_get_pwd) $(git_prompt_info)%f'
}

prompt_gitster_setup() {
  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✗%f "
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✓%f "

  (( ${+functions[git-info]} )) && git-info
}

prompt_gitster_setup() {
  autoload -Uz colors && colors
  autoload -Uz add-zsh-hook

  prompt_opts=(cr percent sp subst)

  add-zsh-hook precmd prompt_gitster_precmd

  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{yellow}✗'
  zstyle ':zim:git-info:keys' format \
    'prompt' ' %F{cyan}%b%c %C%D'

  PROMPT="$(prompt_gitster_status)\$(prompt_gitster_pwd)\$(prompt_gitster_git)%f "
  RPROMPT=''
}

prompt_gitster_setup "$@"
