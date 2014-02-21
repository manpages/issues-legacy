issues_get_config() {
  [ -f .issues/config ] || err "No configuration file found. Consider running 'issues init'."
  info "Evaluating .issues/config..."
  eval "$(cat .issues/config)"
  issues_root="$issues_dir/$issues_team/$issues_project"
  debug "$(cat <<DEBUG

Git:           ${issues_url}
Root:          ${issues_root}
  Dir:           ${issues_dir}
  Team:          ${issues_team}
  Project:       ${issues_project}
Statuses:      ${issues_statuses[@]}
Debug level:   ${issues_debug_level}
DEBUG
)"
}
