issues_tag() {
  [ -z "$1" ] && err "Provide id chain is needed to tag an issue" || issue="$issues_root/$1"
  shift
  [ -z "$1" ] && err "What do you want to tag the issue with?"    || tag="$*"
  [ -d "$issue" ]      || err "Not a valid id chain"
  [ -f "$issue/tags" ] || err "You can't tag comments nowadays, only issues. This limitation might be lifted someday."
  debug "$issue/tags: $(cat $issue/tags)"
  IFS=, read -ra tags <<< "$(cat $issue/tags)"
  tags=( ${tags[@]} $tag )
  debug "Unique tags now: $(printf "%q\n" "${tags[@]}" | sort -u)"
  eval tags=($(printf "%q\n" "${tags[@]}" | sort -u))
  printf "%q," ${tags[@]} > "$issue/tags"
  issues_rmtag "untagged"
}

issues_rmtag() {
  debug "issues_rmtag function is not yet implemented (attempted call: issues_rmtag $*)"
}
