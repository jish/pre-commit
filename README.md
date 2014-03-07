A better pre-commit hook for git.

[![Current version](https://badge.fury.io/rb/pre-commit.png)](https://rubygems.org/gems/pre-commit)
[![Code Climate](https://codeclimate.com/github/jish/pre-commit.png)](https://codeclimate.com/github/jish/pre-commit)
[![Coverage Status](https://coveralls.io/repos/jish/pre-commit/badge.png?branch=master)](https://coveralls.io/r/jish/pre-commit?branch=master)
[![Build status](https://secure.travis-ci.org/jish/pre-commit.png?branch=master)](https://travis-ci.org/jish/pre-commit)
[![Dependency Status](https://gemnasium.com/jish/pre-commit.png)](https://gemnasium.com/jish/pre-commit)
[![Documentation](http://b.repl.ca/v1/yard-docs-blue.png)](http://rubydoc.info/gems/pre-commit/frames)

## Installation

Install the gem

    $ gem install pre-commit

Use the pre-commit command to generate a stub pre-commit hook

    # In your git repo
    $ pre-commit install

This creates a .git/hooks/pre-commit script which will check your git config and run checks that are enabled.

### Verifying the signature

If you wish to verify the installation of the gem you'll need to import the public key, and then install using:

    $ gem install -P MediumSecurity pre-commit

If you get an error, continue reading.

### Installation errors, Importing the public key

If you do not have a copy of my public key (which you probably do not), then you will likely see an error message that looks like this:

    $ gem install -P MediumSecurity pre-commit
    ERROR:  While executing gem ... (Gem::Security::Exception)
        missing signing certificate

First you'll need to import my public key:

    $ curl "https://gist.githubusercontent.com/jish/9380136/raw/4d49b8c44370db533c0916be1682532503b673c6/gem-public_cert.pem" > jish.pem
    $ gem cert --add jish.pem

Then installation should succeed:

    $ gem install -P MediumSecurity pre-commit

## Available checks

These are the available checks:

* white_space
* console_log
* debugger
* pry
* tabs
* jshint
* js_lint
* closure\_syntax\_check
* php (Runs php -l on all staged files)
* rspec_focus (Will check if you are about to check in a :focus in a spec file)
* ruby_symbol_hashrockets (1.9 syntax. BAD :foo => "bar". GOOD foo: "bar")
* local (executes `config/pre-commit.rb` with list of changed files)
* merge_conflict (Will check if you are about to check in a merge conflict)
* migrations (Will make sure you check in the proper files after creating a Rails migration)
* ci (Will run the `pre_commit:ci` rake task and pass or fail accordingly)
* rubocop (Check ruby code style using the rubocop gem. Rubocop must be installed)
* before_all (Check your RSpec tests for the use of `before(:all)`)
* coffeelint (Check your coffeescript files using the [coffeelint gem.](https://github.com/clutchski/coffeelint))
* go (Runs go fmt on a go source file and fail if formatting is incorrect, then runs go build and fails if can't compile)

## Default checks

Use `pre-commit list` to see the list of default and enabled checks and warnings.

## Enabling / Disabling Checks / Warnings

### Git configuration

    git config pre-commit.checks "whitespace, jshint, debugger"

To disable, simply leave one off the list

    git config pre-commit.checks "whitespace, jshint"

### CLI configuration

```ssh
pre-commit <enable|disbale> <git|yaml> <checks|warnings> check1 [check2...]
```

The `git` provider can be used for local machine configuration, the `yaml` can be used for shared
project configuration.

Example move `jshint` from `checks` to `warnings` in `yaml` provider and save configuration to git:
```bash
pre-commit disbale yaml checks   jshint
pre-commit enable  yaml warnings jshint
git add config/pre-commit.yml
git commit -m "pre-commit: move jshint from checks to warnings"
```

Example `config/pre_commit.yml`:
```yaml
---
:warnings_remove: []
:warnings_add:
- :jshint
- :tabs
```

## Configuration providers

`pre-commit` comes with 3 configuration providers:

- `default` - basic settings, read only
- `git` - reads configuration from `git config pre-commit.*`, allow local update
- `yaml` - reads configuration from `/etc/pre-commit.yml`, `$HOME/.pre-commit.yml` and `config/pre-commit.yml`, allows `config/pre-commit.yml` updates

## [Contributing](CONTRIBUTING.md)
