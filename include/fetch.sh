fetch() {
  fetch_do || err "Fetching of the current issue tree failed. See output."
}

fetch_do() {
  info "Fetching the current issue tree..."
  if [ -d "$issues_dir/$issues_team" ]; then
    debug "Issues directory found, pulling last updates from the team."
    ( cd "$issues_dir/$issues_team" && git pull )
  else
    debug "Issues directory not found, cloning"
    git clone $issues_url "$issues_dir/$issues_team"
    if [ ! -d "$issues_dir/$issues_team/$issues_project" ]; then
      debug "Project directory not found, creating it and pushing to the team issue tracker"
      mkdir "$issues_dir/$issues_team/$issues_project"
      touch "$issues_dir/$issues_team/$issues_project/.gitignore"
      ( cd "$issues_dir/$issues_team" && \
        git add . && git commit -am "Start tracking $issues_project project" && \
        git push origin master )
    fi
  fi
}
