issues_git_user() {
  echo "$(git config user.name) <$(git config user.email)>"
}

issues_git_headhash() {
  git log -n1 | head -n1 | cut -d\  -f2
}

issues_git_push() {
  # It works because issues repo is strictly linear and append-only.
  # We will never get merge conflicts. A nasty case would be when two people are making
  # an issue with the same ID chain but this should be resolved manually anyway
  ( cd $issues_root && git pull && git add . && git commit -am "$1" && git push )
}
