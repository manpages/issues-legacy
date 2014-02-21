issues_print_compact() {
  path=$1
  depth=$2
  for x in $(seq 0 $depth); do
    indent+=" "
  done #                                   vvv This thing looks like a lambda
  cat <(echo -n "$(basename $path)/ ")                   \
      "$path/title"            |\
  awk "{print \"${indent}\"\$0}"
}

issues_print_compact_maybe() {
  root_depth=$(issues_dir_depth $issues_root)
  child_depth=$(issues_dir_depth "$2")
  (( depth=$child_depth-$root_depth ))
  if [ -f "$2/status" ]; then
    debug "${2} is an issue, maybe printing compact representation"
    [ $(cat "$2/status") == $1 ] && issues_print_compact "$2" $depth
  fi
}

issues_list_do() {
  [ -z "$1" ] && err "Status is required" || status="$1"
  [ -z "$2" ] && err "Id chain unspecified. Most certainly it's a bug in 'issues'!" || id="$2"
  [ -z "$3" ] || export issues_list_depth=$3
  issue="$issues_root/$id"
  [ ! -d "$issue" ] && err "$id is not a valid id chain"
  for child in $(find $issue -type d); do
    issues_print_compact_maybe $status $child
  done
}

issues_ls() {
  issues_list $*
}

issues_list() {
  issues_fetch
  [ -z $2 ] && issues_list_do "$1" / || issues_list_do $*
}
