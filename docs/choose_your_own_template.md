
## Choose your own template

The most common criticism of this project is the `pre-commit` hook template we use. Everyone has their own environment, and everyone has their own opinions.

Right now the template's goal is portability. We want the hook to work on as many machines, and in as many environments as possible -- that's why it looks so strange.

---

Everyone does not share this opinion. Some people value speed, others their Ruby version switcher of choice. This document is a proposal to allow users to choose the template that is appropriate for their repository.

## Options

### Portable template

The goal of this template will be to work in as many environments as possible.

    $ pre-commit install --portable
    $ pre-commit install --simple
    $ pre-commit install --automatic
    $ pre-commit install # maybe the default option?

### Fast (Manual? Advanced?) template

This template will assume your environment is set up properly, and will value simplicity and speed

```ruby
require 'pre-commit'

PreCommit.run
```

Installation options:

    $ pre-commit install --advanced
    $ pre-commit install --manual
    $ pre-commit install --fast
    $ pre-commit install # maybe the default option?

### RVM template

This template will assume you are using RVM as a Ruby version switcher, and will attempt to setup the RVM environment for you.

    $ pre-commit install --rvm

### rbenv template

This template will assume you are using rbenv as a Ruby version switcher, and will attempt to setup the rbenv environment for you.

    $ pre-commit install --rbenv
