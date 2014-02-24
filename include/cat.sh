issues_cat() {
	[ -z "$1" ] && err "issue id is required" || id="$1"
        issue="$issues_root/$id"
	debug "issue cat $id $issue"
        [ -d "$issue" ] || err "$id is not a valid id"
}