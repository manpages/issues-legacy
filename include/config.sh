get_config() {
  [ -f .issues/config ] || err "No configuration file found. Consider running 'issues init'."
  info "Evaluating .issues/config..."
  eval "$(cat .issues/config)"
  debug "$(cat <<DEBUG

Team:    ${issues_team}
Dir:     ${issues_dir}
Project: ${issues_project}
Git:     ${issues_url}
DEBUG
)"
}
