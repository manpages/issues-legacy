fetch() {
  fetch_do || err "Fetching of the current issue tree failed. See output."
}

fetch_do() {
  info "Fetching the current issue tree..."
  [ -d $issues_dir/$issues_project ] && \
    ( cd $issues_dir/$issues_project && git pull ) || \
    git clone $issues_url $issues_dir/$issues_project
}
