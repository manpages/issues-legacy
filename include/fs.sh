issues_dir_depth() {
  echo "$1" | tr -cd / | wc -c
}
