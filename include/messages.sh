issues_usage() {
  cat <<USAGE
Currently supported verbs: 

  + init:              initializes directory structure, populates .issues/config
  + fetch:             pulls or clones the repository with accordance to .issues/config
  + add(a):            adds an issue with random four-symbol id
                       example: issues add 'Write a manual page for the tool'
  + add-named(an):     adds a named issue. keep the name short and distinct
                       example: issues add-named man 'Write a manual page for the tool'
  + sub(s):            includes a sub-issue with random four-symbol id into a parent issue
                       example: issues sub /man 'Figure out how to write manual pages'
  + sub-named(sn):     includes a named issue into a parent issue
                       example: issues sub-named /man research 'Figure out how to write manual pages'
USAGE
}
