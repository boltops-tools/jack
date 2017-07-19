# Change Log

All notable changes to this project will be documented in this file.
This project *tries* to adhere to [Semantic Versioning](http://semver.org/), even before v1.0.

## [1.4.0]
* fix jack deploy, remove debugging
* fix embedded_eb lookup
* add docs

## [1.3.0]
- flatten cli interface: jack config apply -> jack apply

## [1.2.1]
- fix EB_OPTIONS and early trap for friendly exit

## [1.2.0]
- add jack deploy command
- rename commands to config get and config apply

## [1.1.2]
- remove debugging from version checker

## [1.1.1]
- fix verison checker when eb is not installed

## [1.1.0]
- add jack terminate
- refactoring: https://github.com/tongueroo/jack/pull/6
- autodetect eb_bin and aws_bin

## [1.0.1]
- improve jack eb install error message

## [1.0.0]
- allow --help or -h at the end of the command
- major version bump. been in used and tested for a while now

## [0.3.0]

- Change the default app name convention to: [app]-[role]-[env].  This is a breaking change with version 0.2.0, if you need to use old app name convention override the conventions.app_name_pattern with `jack/settings.yml`.
