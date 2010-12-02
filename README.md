A better pre-commit hook for git.

## Installation

This is how we have it configured right now. Hopefully these installation steps will become more friendly in the future.

Rename the default git pre-commit hook to 'whitespace'

    # Starting in your git repo
    $ cp .git/hooks/pre-commit.sample .git/hooks/whitespace

Clone this pre-commit repository

    # From your git repo
    $ git clone https://jish@github.com/jish/pre-commit.git ../pre-commit

Add a soft link to the pre-commit hook

    # From your git repo
    $ ln -s ../pre-commit/pre-commit.rb .git/hooks/pre-commit

## Configuration

By default all of the pre-commit checks will run

* white_space
* console_log
* debugger
* tabs
* closure\_syntax\_check

To configure which checks you would like to run, simply set the `pre-commit.checks` git configuration setting.

To enable `white_space` and `tab` checks:

    # From your git repo
    $ git config "pre-commit.checks" "white_space, tabs"

To enable `white_space`, `console_log` and `debugger` checks:

    # From your git repo
    $ git config "pre-commit.checks" "white_space, console_log, debugger"
