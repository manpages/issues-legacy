issues_fetch() {
  issues_fetch_do || err "Fetching of the current issue tree failed. See output."
}

issues_fetch_if_needed() {
	debug "Issues fetch id needed, not implemented"
}

issues_fetch_do() {
  info "Fetching the current issue tree..."
  if [ -d "$issues_dir/$issues_team" ]; then
    debug "Issues directory found, pulling last updates from the team."
    ( cd "$issues_dir/$issues_team" && git pull )
  else
    debug "Issues directory not found, cloning"
    git clone $issues_url "$issues_dir/$issues_team"
    if [ ! -d "$issues_root" ]; then
      debug "Project directory not found, creating it and pushing to the team issue tracker"
      mkdir -p "$issues_root"
      touch "$issues_root/.gitignore"
      ( cd "$issues_dir/$issues_team" && \
        git add . && git commit -am "Start tracking $issues_project project" && \
        git push origin master )
    fi
  fi
}
