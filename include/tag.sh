issues_tag() {
  arg1="$1"
  [ -z "$1" ] && err "An id chain is needed to tag an issue" || issue="$issues_root/$1"
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
  issues_rmtag "$arg1" "untagged" # dirty dirty
}

issues_rmtag() {
  debug "issues_rmtag $*"
  [ -z "$1" ] && err "An id chain is needed to tag an issue" || issue="$issues_root/$1"
  shift
  [ -z "$1" ] && err "Which tag do you want to remove?"      || tag="$*"
  debug "Issue: $issue"
  [ -d "$issue" ] || err "Not a valid id chain"
  [ -f "$issue/tags" ] || err "You can't tag comments nowadays, only issues. This limitation might be lifted someday."
  debug "$issue/tags: $(cat $issue/tags)"
  IFS=, read -ra tags <<< "$(cat $issue/tags)"
  tags1=(  )
  for i in ${tags[@]}; do
    [ i == $tag ] || tags1=( ${tags1[@]} "$i" )
  done
  printf "%q," ${tags1[@]} > "$issue/tags"
}
