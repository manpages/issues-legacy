issues_add() {
  info "Adding issue"
  issues_add_do / "$(issues_nextid /)" $*
}

issues_add-named() {
  info "Adding named issue"
  issues_add_do / $*
}

issues_sub() {
  info "Adding sub-issue"
  parent="$1" && shift
  issues_add_do "$parent" "$(issues_nextid $parent)" $*
}

issues_sub-named() {
  info "Adding named sub-issue"
  issues_add_do $*
}

issues_nextid() {
  debug "Generating issue id"
  path=$1
  candidate=$(LC_CTYPE=C </dev/urandom tr -dc a-z0-9_ | head -c4)
  debug "Candidate id: ${candidate}"
  [ -d "$issues_root/$path/$candidate" ] && issues_nextid $path || echo $candidate
}

issues_add_generic() {
  debug "Executing generic issue creation function"
  [ -z "$1" ] && err "Path is required for creating a sub-issue" || path="$1"
  [ -z "$2" ] && err "Name is required for a named issue"        || id="$2"
  shift && shift
  [ -z "$1" ] && err "Issue description is required"             || title="$*"
  [ -d "$issues_root/$path/$id" ] && err "Issue with id ${id} already exists in ${path}"
  issue="$issues_root/$path/$id"
  mkdir "$issue"
  echo "$title" > "$issue/title"
  [ -z $EDITOR ] && editor=vi || editor=$EDITOR
  echo -e "${title}\n---" > "$issue/commentary"
  $editor "$issue/commentary"
  echo -n "open" > "$issue/status"
  echo -n "untagged" > "$issue/tags"
  echo "$(issues_git_user)" > "$issue/author"
  echo "$(issues_git_headhash)" > "$issue/head"
}

issues_add_do() {
  issues_add_generic $*
  issues_git_push "Add issue #${id}: ${title}"
}

# Sadly, we can't use alias here
issues_a() {
  issues_add $*
}
issues_an() {
  issues_add-named $*
}
issues_s() {
  issues_sub $*
}
issues_sn() {
  issues_sub-named $*
}
