issues_assign() {
  arg1="$1"
  [ -z "$1" ] && err "An id chain is needed to tag an issue"   || issue="$issues_root/$1"
  shift
  [ -z "$1" ] && err "Who do you want to assign to this issue? Or whom?" || assignee="$*"
  [ -d "$issue" ]      || err "Not a valid id chain"
  [ -f "$issue/status" ] || err "You can't assign people to comments. It doesn't even make sense."
  echo -n $assignee > $issue/assignee
  issues_git_push "Assign ${assignee} to #${arg1}"
}
