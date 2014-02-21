issues_print_compact() {
  indent=""
  path=$1
  depth=$2
  #for x in $(seq 0 $depth); do
  #  indent+=""
  #done #                                   vvv This thing doesn't look like a lambda anymore
  cat <(echo -n "${path#$issues_root}/ ")                   \
      "$path/title" #            |\
  #awk "{print \"${indent}\"\$0}"
}

issues_print_compact_maybe() {
  depth=0
  root_depth=$(issues_dir_depth $issues_root)
  child_depth=$(issues_dir_depth "$2")
  (( depth=$child_depth-$root_depth ))
  debug "Child depth: $child_depth Root depth: $root_depth | Calculated depth: $depth"
  if [ -f "$2/status" ]; then
    debug "${2} is an issue, maybe printing compact representation"
    [ $(cat "$2/status") == $1 ] && issues_print_compact "$2" $depth
  fi
}

issues_list_do() {
  debug "Launching issues_list_do with $*"
  [ -z "$1" ] && err "Status is required" || status="$1"
  [ -z "$2" ] && err "Id chain unspecified. Most certainly it's a bug in 'issues'!" || id="$2"
  [ -z "$3" ] || export issues_list_depth=$3
  [ $id == "/" ] && id=""
  issue="$issues_root/$id"
  [ ! -d "$issue" ] && err "$id is not a valid id chain"
  for child in $(find $issue -type d | xargs ls -1td); do
    issues_print_compact_maybe $status $child
  done
  return 0
}

issues_ls() {
  issues_list $*
}

issues_list() {
  issues_fetch
  if [ -z "$2" ]; then 
    debug "issues_list> No id chain supplied, using /"
    issues_list_do "$1" /
  else
    debug "issues_list> Id chain supplied: $*"
    issues_list_do $*
  fi
}
