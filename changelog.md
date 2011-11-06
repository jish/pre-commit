
## 0.1.17

* Fixing typos
* Adding a php check

## 0.1.16

* Detecting leading whitespace before leading tabs in the tabs check.

## 0.1.15

* The previous release handled some error reporting when using therubyracer vm. This release fixes errors if you're using ExecJS and *do not* have therubyracer installed.

## 0.1.14

* Better error reporting when JSHint stops scanning a file for errors half way through

## 0.1.13

* Adding a JSHint config file. You can put your options in a .jshintrc file
* Adding a ci check. You can run a quick test suite each time you commit.

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
