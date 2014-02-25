issues_print_short_() {
        #echo -n "$1:	"
	printf "%7.7s: " $1
}

issues_print_pretty_() {
	path=$1
	echo "ISSUE ${path#$issues_root}/ "
	for item in status tags; do # items not ending with aline feed
		issues_print_short_ $item
		cat "$path/$item" 2>/dev/null
		echo " "
	done
	for item in author title commentary; do
		issues_print_short_ $item
		cat "$path/$item" 2>/dev/null
	done
}

issues_cat() {
	[ -z "$1" ] && err "issue id is required"
  issue="$issues_root/$1"
	debug "issues cat $*"
  [ -d "$issue" ] || err "$id is not a valid id"
  for child in $(find $issue -type d | xargs ls -1td); do
    issues_print_pretty_ $child
  done
  return 0
}
