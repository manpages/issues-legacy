issues_set_debug_level() {
  export ISSUES_DEBUG_LEVEL=1
  [ $1 == "none" ] && export ISSUES_DEBUG_LEVEL=0
  [ $1 == "errors" ] && export ISSUES_DEBUG_LEVEL=1
  [ $1 == "messages" ] && export ISSUES_DEBUG_LEVEL=2
  [ $1 == "info" ] && export ISSUES_DEBUG_LEVEL=3
  [ $1 == "debug" ] && export ISSUES_DEBUG_LEVEL=4
}

error() {
  [[ $ISSUES_DEBUG_LEVEL -ge 1 ]] && echo -e "[error] $1" 1>&2
}

message() {
  [[ $ISSUES_DEBUG_LEVEL -ge 2 ]] && echo -e "[msg] $1"
}

info() {
  [[ $ISSUES_DEBUG_LEVEL -ge 3 ]] && echo -e "[info] $1"
}

debug() {
  [[ $ISSUES_DEBUG_LEVEL -ge 4 ]] && echo -e "[debug] $1" 1>&2
}
