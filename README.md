issues
===

Bullshit-free issue tracker.


### Usecase

#### Initialization

```
> issues init MyProject
ok.
```


#### Issue listing

```
> issues new MyProject
you have no new notifications.

> issues open MyProject
2 Implement indexing

> issues closed MyProject
1 Implement adding articles

> issues resolved MyProject
1 Implement adding articles

> issues wontfix MyProject
3 Do a victory dance
```

#### Issue reading

```
> issues read 1 MyProject
Status: resolved
Title: Implement commentaries

(a) magbo created issue
Tue Feb 18 06:17:46 CET 2014
We need commentaries
===

  (b) mkaito commented
  Tue Feb 18 06:17:54 CET 2014
  I don't think so.

  (c) mkaito commented
  Tue Feb 18 07:18:02 CET 2014
  Nvm, implemented.

```


#### Adding issues and commenting
```
issues add MyProject "Issue Summary"
cat issue.md | issues add MyProject "Issue Summary"

issues comment 1c 'Thanks!'

issues resolve 2
cat message.md | issues resolve 2

issues wontfix 2
cat message.md | issues wontfix 2
```
