issues_set_debug_level() {
  echo "SETTING ISSUES_DEBUG_LEVEL TO 1"
  export ISSUES_DEBUG_LEVEL=1
  [ $1 == "none" ] && export ISSUES_DEBUG_LEVEL=0 && return
  echo "SETTING ISSUES_DEBUG_LEVEL TO 0"
  [ $1 == "errors" ] && export ISSUES_DEBUG_LEVEL=1 && return 
  echo "SETTING ISSUES_DEBUG_LEVEL TO 2"
  [ $1 == "messages" ] && export ISSUES_DEBUG_LEVEL=2 && return
  echo "SETTING ISSUES_DEBUG_LEVEL TO 3"
  [ $1 == "info" ] && export ISSUES_DEBUG_LEVEL=3 && return
  echo "SETTING ISSUES_DEBUG_LEVEL TO 4"
  [ $1 == "debug" ] && export ISSUES_DEBUG_LEVEL=4 && return
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
