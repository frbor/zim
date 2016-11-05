#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#

gst_get_status() {
  print "%(?::%F{9}! %s)"
  #print "%(?:%F{10}➜:%F{9}➜%s)"
}

gst_get_pwd() {
  prompt_short_dir="$(short_pwd)"
  git_root="$(command git rev-parse --show-toplevel 2> /dev/null)" && \
  prompt_short_dir="${prompt_short_dir#${$(short_pwd $git_root):h}/}"
  print ${prompt_short_dir}
}

prompt_context() {
  #if [[ ${USER} != ${DEFAULT_USER} || -n ${SSH_CONNECTION} ]]; then
  if [[ -n ${SSH_CONNECTION} ]]; then
    print " %F{cyan}%(!.%{%F{blue}%}.)%m "
    #print " %F{cyan}%(!.%{%F{blue}%}.)${USER}@%m"
  fi
}

prompt_gitster_precmd() {
  PROMPT='$(gst_get_status)$(prompt_context)%F{cyan}$(gst_get_pwd) $(git_prompt_info)%f'
}

prompt_gitster_setup() {
  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✗%f "
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✓%f "

  autoload -Uz add-zsh-hook

  add-zsh-hook precmd prompt_gitster_precmd
  prompt_opts=(cr subst percent)
}

prompt_gitster_setup "$@"
