# Jack and the Elastic Beanstalk

[![ReadmeCI](http://www.readmeci.com/images/readmeci-badge.svg)](http://www.readmeci.com/tongueroo/jack)
[![CircleCI](https://circleci.com/gh/tongueroo/jack.svg?style=svg)](https://circleci.com/gh/tongueroo/jack)
[![Code Climate](https://codeclimate.com/github/tongueroo/jack/badges/gpa.svg)](https://codeclimate.com/github/tongueroo/jack)
[![Test Coverage](https://codeclimate.com/github/tongueroo/jack/badges/coverage.svg)](https://codeclimate.com/github/tongueroo/jack)
[![Join the chat at https://gitter.im/tongueroo/jack](https://badges.gitter.im/tongueroo/jack.svg)](https://gitter.im/tongueroo/jack?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Support](https://img.shields.io/badge/get-support-blue.svg)](https://boltops.com?utm_source=badge&utm_medium=badge&utm_campaign=jack)


Jack allows you to easily manage your AWS Elastic Beanstalk Jack environments.

Jack provides a `jack apply` command to update the Elastic Beanstalk environment.   Before uploading the new configuration Elastic Beanstalk jack first downloads the current configuration and then does a diff on the changes that are about to be applied.  This gives a preview of exactly what will be changed.  This is particularly helpful when changes are made through the EB GUI and are out of sync with what is stored in the downloaded `jack/cfg` files.

See [jack-eb.com](http://jack-eb.com) for full documentation.

This blog post also provides a good introduction and shows off useful examples of what you can do with the jack tool: [Jack and the Elastic Beanstalk — Tool to Manage AWS Elastic Beanstalk Environments](https://medium.com/@tongueroo/jack-and-the-elastic-beanstalk-easily-manage-aws-environments-3ab496f08ad2#.o7w3x0yd9).

## Use Cases

* Allows codification of the infrastructure by downloading the configuration. You can save the downloaded configs into version control.
* Safely upload new configs by previewing the changes before actually uploading and applying the configuration to the infrastructure.
* Moving EB enviroments from one EB application to another EB application. EB provides a way to clone environments within an application but is unable to move the enivornment to an entirely new application. This is useful if you want to "rename" the EB application.

## Installation

If you want to quickly install jack without having to worry about jack’s dependencies you can simply install the Bolts Toolbelt which has jack included.

```sh
brew cask install boltopslabs/software/bolts
```

Or if you prefer you can install ufo with RubyGems

```sh
gem install jack-eb
```

Note that the gem is called jack-eb but the actual command that is installed is called `jack`.  If you are installing jack with RubyGems you will need to handle installing the additional dependencies yourself.

Full installation instructions are on the [Installation docs](http://jack-eb.com/docs/install/).

## Conventions

Before using the tool, it is good to know that jack follows a convention for the environment and application name.  This is done in order to keep the jack commands simple and short.  The convention is:

<pre>
environment_name: [app]-[role]-[env]
application_name: [app]
</pre>

A concrete example is helpful:

<pre>
environment_name: hi-web-prod
application_name: hi
</pre>

The example above means the EB application name will be `hi` and the environment name will be `hi-web-prod`.  By convention, the first word, separated by a '-', of the environment name is the application name.  This convention can be overridden easily via by configuring the [settings](http://jack-eb.com/docs/settings/). It is also possible to override the application name convention from the cli with the `--app` flag.

## Quick Usage

Here's a quick overview of how to use jack:

```sh
brew cask install boltopslabs/software/bolts
git clone https://github.com/tongueroo/hi # demo sinatra app
cd hi
jack create hi-web-stag # creates a EB App named hi and EB Environment named hi-web-stag
jack download hi-web-stag
# ... make adjustments to jack/cfg/hi-web-stag.yml ...
jack upload hi-web-stag
```

See [jack-eb.com](http://jack-eb.com) for full documentation.

## Contributing

Everyone can contribute to make jack better.  Please fork the project and open a pull request! We love your pull requests. Contributions are encouraged and welcomed!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
