if [ -f ".issues/config" ]; then
  issues_get_config
  issues_codegen_statuses=""
  issues_asterisk='*'
  for s in ${issues_statuses[@]}; do
    issues_codegen_statuses+="
      issues_${s}() {
        issues_status_do \"${s}\" \$*
      };
      "
  done

  eval "$issues_codegen_statuses"

  issues_status_do() {
    new_status=$1 && shift
    [ -z "$1" ] && err "Id chain (like 'wasd/x0c3') is required for setting status to an issue" || path="$1"
    [ ! -d "$issues_root/$path" ] && err "$path is not a valid id chain"
    issues_fetch_if_needed
    echo -n "$new_status" > "$issues_root/$path/status"
    issues_git_push "Set status for #$(basename $path) to $new_status"
  }
else
  echo "[warn] Status handling code can't be generated, no config supplied."
  export issues_statuses=()
fi
