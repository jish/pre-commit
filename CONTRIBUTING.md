# Contributing

## Reporting issues

We would love to help if you are having a problem. Feel free to open an issue. We ask that you please provide as much detail as possible.

### Closing old issues

Tickets that require user feedback will be marked with `need-info`
label. In case there will be no feedback on such ticket in two
months we will close that ticket. the ticket will be reopened as
soon as user can provide requested information.

## Adding extra check plugins

You can add extra checks by creating gem with a new check in
`lib/plugins/pre_commit/checks/`, check this project directory for
examples:
[lib/plugins/pre_commit/checks](lib/plugins/pre_commit/checks).

## Adding extra configuration provider plugins

You can add extra providers by creating gem with a new provider in
`lib/plugins/pre_commit/configuration/providers/`, check this
project directory for examples:
[lib/plugins/pre_commit/configuration/providers](lib/plugins/pre_commit/configuration/providers).
