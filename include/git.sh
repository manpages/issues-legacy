issues_git_user() {
  echo "$(git config user.name) <$(git config user.email)>"
}

issues_git_headhash() {
  git log -n1 | head -n1 | cut -d\  -f2
}

issues_git_push() {
  ( cd $issues_root && git add . && git commit -am "$1" && git push )
}
