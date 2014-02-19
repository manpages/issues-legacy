bye() {
  bye_do message $*
}

bye_do() {
  [ -z $4 ] && signal=TERM || signal=$4
  trap "$1 \"$2\"; exit $3" $signal
  kill -s $signal $ISSUES_TOP_PID
}

ok() {
  bye_do info "Done" 0
}

err() {
  bye_do error "$1" 1
}
