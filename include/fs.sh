issues_dir_depth() {
  echo "$1" | LC_CTYPE=C tr -cd / | wc -c
}
