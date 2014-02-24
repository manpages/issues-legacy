issues_init() {
  info "Adding project to team's issues repository..."
  info "Using $(issues_get_issues_dir) as the issues repository directory."
  [ -d .git ] || err "Not a git project"
  [ -d $(issues_get_issues_dir) ] && info "Issues directory is already created, skipping" || mkdir -p $(issues_get_issues_dir) 
  [ -f .issues/config ] && info "Issues configuration is already created, skipping" || issues_init_dot_issues
  message "The issues configuration is bootstrapped and written to .issues/config\nNow put credentials there and run 'issues fetch'."
}

issues_get_issues_dir() {
  if [ -z $issues_dir ]; then
    [ -z $ISSUES_DIR ] && issues_dir="${HOME}/.issues" || issues_dir=$ISSUES_DIR
  fi
  echo $issues_dir
}

issues_init_dot_issues() {
  mkdir -p .issues
  message "Configuration file was written to .issues/config. Review it and run 'issues fetch'."
  cat > .issues/config <<CONFIG
## This file gets evalled, so no spaces near =
## Debug levels: debug info messages errors none
# Name of your team
issues_team="default"
# Default issues directory (possibly created by issues init)
issues_dir="$(issues_get_issues_dir)"
# Name of this project
issues_project="${PWD##*/}"
# URI of Git repository that stores issues of your team's projects
issues_url="git@github.com:\${issues_team}/issues.git"
# List of allowed statuses
issues_statuses=('open' 'resolved' 'working' 'rejected') 
# Debug level of issues program.
issues_debug_level="messages"
CONFIG
  echo ".issues" >> .gitignore
}
