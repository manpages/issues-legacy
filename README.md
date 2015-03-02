issues
===

Bullshit-free issue tracker.

Usage
===

```
Currently supported verbs: 

  + init:                 initializes directory structure, populates .issues/config
  + pull:                 pulls or clones the repository with accordance to .issues/config
  + add(a):               adds an issue with random four-symbol id
                          example: issues add 'Write a manual page for the tool'
  + add-named(an):        adds a named issue. keep the name short and distinct
                          example: issues add-named man 'Write a manual page for the tool'
  + sub(s):               includes a sub-issue with random four-symbol id into a parent issue
                          example: issues sub /man 'Figure out how to write manual pages'
  + sub-named(sn):        includes a named issue into a parent issue
                          example: issues sub-named /man research 'Figure out how to write manual pages'
  + comment id:           adds a commentary
                          example: issues comment ocaw
  + open, resolved, etc:  sets the status of an issue to the one supplied
                          example: issues resolved ocaw/wasd
  + list status [id]:     lists all the issues of given status under optionally supplied id chain in 
                          reverse chronological order
                          example: issues list open ocaw/wasd
  + cat id:               pretty-prints discussion of an issue
                          example: issues cat ocaw
  + tree id:              pretty-prints discussion of an issue if form of indented tree
                          example: issues tree ocaw
  + tag:                  tags an issue (doesn't work with comments) with a tag
                          example: issues tag ocaw seen
  + rmtag:                removes a tag from an issue
                          example: issues rmtag ocaw fun
  + assign:               assigns a person to an issue
                          example: issues assign ocaw/wasd magbo
```
