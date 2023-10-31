## 0.40.0

* Add Ruby 3.2 support -- deprecate `File.exists?`
* Missing migrations check only lists versions missing from schema

## 0.39.0

* Handle new Rails migration format

## 0.38.1

* Fix bug when there is no standard output when detecting the grep version

## 0.38.0

* Ignore standard error when checking grep version
* Security: Depend on RuboCop ~> 0.49

## 0.37.0

* Skip running binary test on known binary files and known source files.
  This improves performance by not opening and reading each file before it is
  committed.

## 0.36.0

* Add more RSpec focus syntaxes to the RSpec focus check

## 0.35.0

* Fix a bug in the `go_fmt` plugin

## 0.34.0

* Update to latest pluginator version to fix bug with bundler 1.15

## 0.33.0

* Remove post-install message, it wasn't functioning properly anyway :(
* Upgrade JSHint to 2.9.4
* Fix Ruby warnings

## 0.32.0

* Go back to original binary file check. It was creating false-positives.

## 0.31.0

* Handle empty file sizes on Windows
* Add a SourceTree pre-commit hook template `pre-commit install --sourcetree`

## 0.30.0

* Fixed a bug where the default pre-commit hook could not be installed on some
systems.

## 0.29.0

* Fixed a bug where version 0.27.0 and 0.28.0 could not be installed on Windows.

## 0.28.0

* The binary check handles unicode source files.

## 0.27.0

* Removed the closure check
* Separated gofmt and gobuild checks
* Run tests against more (newer) versions of Ruby -- 2.2 & 2.3
* config.ru is an allowed file for the rubocop check
* Added a `pre-commit new` command to generate a new pre-commit plugin
* The pry check now cheks for `binding.remote_pry` and `binding.remote_pry_em`

## 0.26.0

* Add byebug support to the debugger check

## 0.25.0

* Rubocop check was not filtering file extensions properly. It was ignoring the dot `.` (e.g. `.foo`).
* Users should now be able to commit from subdirectories (e.g. `$ cd subdir`, `$ git commit`).

## 0.24.0

* Whitespace check will not run if there are no staged files.
* The `pre-commit` script now runs properly in GitHub for Mac.

## 0.23.0

* RuboCop checks more than just .rb files (`.gemspec`, `Rakefile`, etc.)

## 0.22.1

* `pre-commit run` used to always exit with the same status code. Now it exits with 0 on success, 1 on error

## 0.22.0

* Read all versions from schema files in the migration check.

## 0.21.0

* Ignore `no rvm in path` errors if rvm is not present.

## 0.20.0

* Add the ability to pass command line flags to Rubocop. `rubocop.flags`
* Upgrade JSHint to 2.5.4
* The `local` check will look for and prefer `config/pre_commit.rb` in addition to `config/pre-commit.rb`
* Allow committing a large number of files (> 7,000)

## 0.19.0

* Add a `pre-commit run git` command to run `pre-commit` checks on all files tracked by git.
* Filenames containing spaces no longer break the Grep check

## 0.18.0

* Improve version number discovery in schema and migration files so that a blank `schema.rb` (with version `0`) does not fail the migration check
* Fix `pre-commit run <file-list>`.

## 0.17.0

* Fix a bug where `pre-commit list` would bomb when you had older versions of `pre-commit` installed
* Smarter debugger check allows you to leave `debugger` in comments, quotes, or other intended uses
* Add a `pre-commit run` CLI command
* Fix intermittent install failures #154

## 0.16.3

* Account for the `RuboCop` top level namespace case sensitivity change.

## 0.16.2

* Fix an error that occurred when adding a git submodule

## 0.16.1

* Adds --force-exclusion option to rubocop CLI

## 0.16.0

* Add a JSON check -- checks if JSON is parsable.
* Add a YAML check -- checks if YAML is parsable.
* Add an SCSS-Lint check -- scss-lint is a tool to help keep your SCSS files clean and readable.
* The `console.log` check will run on coffe script files as well.

## 0.15.0

* Add a standard way for checks to find a config file. `check_name.config`

## 0.14.1

* use `get` to read rubocop.config, fix #124

## 0.14.0

* Add a `Go` check
* Fix for bug: "Could not find template default"

## 0.13.0

* Hashrockets check only runs on Ruby files
* Fix "uninitialized constant" bug when running Rubocop
* Add [CSSLint](http://csslint.net/) support
* New configuration strategies -- backwards compatible with old configuration

## 0.12.0

* Add a `before_all` check for RSpec `before(:all)` blocks.
* Add a `coffeelint` check.
* Do not load `execjs` unless JavaScript checks are enabled
* Load checks with [pluginator](https://github.com/rvm/pluginator)
* Allow configuration of warnings (log to `stderr`, but do not abort the commit) in `git config pre-commit.warnings`
* Use the Apache 2.0 liscense
* The `nb_space` check reads files in utf-8

## 0.11.0

* Converted the hook template to shell (instead of ruby) keep an eye out for problems, and file an issue if anything comes up https://github.com/jish/pre-commit/issues
* Added a `pre-commit.ruby` git config option. If this option is set, the hook will use that ruby. `git config pre-commit.ruby "ruby"`
* Drop `Ruby 1.8.7` support

## 0.10.0

* Enhancement: Migration check will ensure the proper versions are in the schema file

## 0.9.2

* Does not run the debugger check on `Gemfile`, `Gemfile.lock`

## 0.9.0

* adding spec directory to checked dirs of pry and debugger

## 0.8.1

* Better system ruby suppot on Mac OS.

## 0.8.0

* Added a check for `binding.pry`
* Allowing `mount Application::API => '/api'` syntax in the hashrocket check
* Added a check for `:focus` in rspec tests.

## 0.7.0

* Added a `local` check. Will run `config/pre-commit.rb` and pass or fail accordingly.

## 0.6.1

* Properly require `ruby_symbol_hashrockets`.

## 0.6.0

* Adding a Ruby hashrocket syntax check. If you're into that kind of thing.

## 0.5.0

* Checking for `rbenv` on boot as well as `rvm`

## 0.4.0

* Detecting if the pre-commit gem is no longer installed. This is usually due to a Ruby version upgrade.
* Only running the ConsoleLog check on javascript files.

## 0.3.1

* Fix for Mountain Lion's grep.

## 0.3.0

* Adding the merge conflict check to the list of default checks

## 0.2.0

* Fixing a segmentation fault that was occurring when some people did not have the proper ruby setup in their environment
* Adding the option to overwrite existing pre-commit hooks during installation

## 0.1.19

* Removing arguments from the shebang line as these are not interpreted the same way on all operating systems

## 0.1.18

* Upgrading JSHint
* Playing nicely with execjs

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
