issues_pretty_x=8

issues_print_short_() {
        #echo -n "$1:	"
	printf "%${issues_pretty_x}.${issues_pretty_x}s: " $1
}

issues_print_pretty_() {
	path=$1
  [ -f $path/status ] && t="ISSUE" || t="COMMENT"
  printf "%${issues_pretty_x}s: " $t
	echo "${path#$issues_root}/ "
  if [ $t == "ISSUE" ]; then
    for item in "status" "tags" "assignee"; do # items not ending with aline feed
      if [ -f "$path/$item" ]; then
        issues_print_short_ $item
        cat "$path/$item" <(echo) 2>/dev/null
      fi
    done
  fi
	for item in author title; do
		issues_print_short_ $item
		cat "$path/$item" 2>/dev/null
	done
  cat "$path/commentary" | awk '{print "          "$0}'
}

issues_print_compact() {
  path=$1
}

issues_cat() {
	[ -z "$1" ] && err "issue id is required"
  issue="$issues_root/$1"
	debug "issues cat $*"
  [ -d "$issue" ] || err "$id is not a valid id chain"
  for child in $(find $issue -type d | xargs ls -1td); do
    issues_print_pretty_ $child
  done
  return 0
}

issues_tree() {
  [ -z "$1" ] && err "Issue id is required"
  issue="$issues_root/$1"
  debug "Printing issue tree for $1"
  debug "Children: $(ls -1tp $issue | grep /)"

  root_depth=$(issues_dir_depth $issues_root)
  child_depth=$(issues_dir_depth "$issue")
  (( depth=$child_depth-$root_depth ))
  indent=""
  for x in $(seq 1 $depth); do
    indent+="    "
  done
  debug "Depth: $depth"

  [ -d "$issue" ] || err "$id is not a valid id chain"
  cat <(issues_print_pretty_ "$issue") <(echo -e "\n") | awk "{print \"${indent}|\"\$0}"

  for child in $(ls -1tp $issue | grep /); do
    next="$1/$child"
    issues_tree ${next%/}
  done
}
