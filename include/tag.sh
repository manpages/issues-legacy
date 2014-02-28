issues_tag() {
  arg1="$1"
  [ -z "$1" ] && err "An id chain is needed to tag an issue"   || issue="$issues_root/$1"
  shift
  [ -z "$1" ] && err "What do you want to tag the issue with?" || tag="$*"
  [ -d "$issue" ]      || err "Not a valid id chain"
  [ -f "$issue/tags" ] || err "You can't tag comments nowadays, only issues. This limitation might be lifted someday."
  debug "$issue/tags: $(cat $issue/tags)"
  IFS=, read -ra tags <<< "$(cat $issue/tags)"
  tags=( ${tags[@]} $tag )
  debug "Unique tags now: $(printf "%q\n" "${tags[@]}" | sort -u)"
  eval tags=($(printf "%q\n" "${tags[@]}" | sort -u))
  printf "%q," ${tags[@]} > "$issue/tags"
  issues_rmtag "$arg1" "untagged" # dirty dirty
  issues_git_push "Tagged #$arg1 with $tag"
}

issues_rmtag() {
  arg1="$1"
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
    debug "Found tag: ${i}"
    [ $i == $tag ] || tags1=( ${tags1[@]} "$i" )
  done
  printf "%q," ${tags1[@]} > "$issue/tags"
  issues_git_push "Removed $tag from #${arg1}"
}

issues_tags() {
  tags=(  )
  for tf in $(find $issues_root -name "tags"); do
    debug "Adding tags from file $tf"
    tags1=(  )
    IFS=, read -ra tags1 <<< "$(cat $tf)"
    tags=( ${tags[@]} ${tags1[@]} )
  done
  eval tags=($(printf "%q\n" "${tags[@]}" | sort -u))
  echo ${tags[@]}
}
