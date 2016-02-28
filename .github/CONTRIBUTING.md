# Contributing

## Reporting issues

We would love to help if you are having a problem. Feel free to [open an
issue](https://github.com/jish/pre-commit/issues). We ask that you please
provide as much detail as possible.

## Adding extra checks

A set of `pre-commit` checks is included in this repo. If you find a bug or
wish to create an enhancement to one of these checks, please open an issue or a
pull request.

You can also create your own `pre-commit-plugin` in a separate repo. See the
[pre-commit-plugins organization](https://github.com/pre-commit-plugins) on
GitHub for examples.

## Adding extra configuration sources

Currently `pre-commit` supports reading configuration from `git config`, your
shell environment (through `ENV`), or a YAML file. See
`lib/plugins/pre_commit/configuration/providers/` for more information and
details on how to create a new configuration provider if necessary.

---

### Closing old issues

Issues that require user feedback will be marked with the `need info`
label. If there is no feedback in two months we will close the issue. If an
issue is closed in this way, the requester or the core team will reopen the
issue when more information is provided.
