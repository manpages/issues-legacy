init() {
  info "Adding project to team's issues repository..."
  info "Using $(get_issues_dir) as the issues repository directory."
  [ -d .git ] || err "Not a git project"
  [ -d $(get_issues_dir) ] && info "Issues directory is already created, skipping" || mkdir -p $(get_issues_dir) 
  [ -d .issues ] && info "Local issues configuration directory is already created, skipping" || init_dot_issues
}

get_issues_dir() {
  if [ -z $issues_dir ]; then
    [ -z $ISSUES_DIR ] && issues_dir="${HOME}/.issues" || issues_dir=$ISSUES_DIR
  fi
  echo $issues_dir
}

init_dot_issues() {
  mkdir .issues
  message "Configuration file was written to .issues/config. Review it and run 'issues fetch'."
  cat > .issues/config <<CONFIG
issues_team="default"
issues_dir="$(get_issues_dir)"
issues_project="${PWD##*/}"
issues_url="git@github.com:\${issues_team}/issues.git"
CONFIG
  echo ".issues" >> .gitignore
}
