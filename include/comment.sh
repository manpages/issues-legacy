issues_comment() {
  info "Adding commentary"
  [ -z "$1" ] && err "Path is required for adding a commentary" || path="$1"
  id="$(issues_nextid "$1")"
  shift
  [ -z "$1" ] && title="commentary" || title="$*"
  issues_add_generic $path $id $title
  # drity dirty
  rm "$issues_root/$path/$id/tags" "$issues_root/$path/$id/status"
  issues_git_push "Add commentary for #${id}"
}
