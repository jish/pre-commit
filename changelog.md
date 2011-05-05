
## 0.1.10

* Adding a migration sanity check

## 0.1.9

* Allowing commented out console.log to pass (only single line comment support for now =/)

## 0.1.7

* Adding JSHint support
* Making JSHint a default check

## 0.1.6

### Bugs
* Pre commit would fail -- silently :( -- when adding new .js files due to an error in the jslint check.

## 0.1.3

### Bugs
* On the debugger check, only checking the lines that the committer has added. (thanks to staugaard for pointing this out)

### Enhancements
* Adding a reminder that the pre-commit check can be bypassed using `git commit -n`

## 0.1.2

### Bugs
* The tabs check was detecting leading tabs in binary files. The tabs check no longer checks binary files. (thanks to morten for pointing this out)
