A better pre-commit hook for git.

## Installation

Install the gem
    $ gem install pre-commit

Use the pre-commit command to generate a stub pre-commit hook

    # In your git repo
    $ pre-commit install

This creates a .git/hooks/pre-commit script which will check your git config and run checks that are enabled.

## Configuration

These are the available checks:

* white_space
* console_log
* debugger
* tabs
* closure\_syntax\_check
* js_lint_all (Runs JSLint on all staged JS files)
* js_lint_new (Runs JSLint on all new staged JS files)

To configure which checks you would like to run, simply set the `pre-commit.checks` git configuration setting. 

To enable `white_space` and `tab` checks:

    # From your git repo
    $ git config "pre-commit.checks" "white_space, tabs"

To enable `white_space`, `console_log` and `debugger` checks:

    # From your git repo
    $ git config "pre-commit.checks" "white_space, console_log, debugger"

Note: If no checks are configured, a default set of checks is run: white_space, console_log, debugger, tabs, closure_syntax_check and js_lint_new.
