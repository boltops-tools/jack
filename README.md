# Jack and the Elastic Beanstalk

[![ReadmeCI](http://www.readmeci.com/images/readmeci-badge.svg)](http://www.readmeci.com/tongueroo/jack)
[![Build Status](https://travis-ci.org/tongueroo/jack.svg?branch=master)](https://travis-ci.org/tongueroo/jack)
[![Code Climate](https://codeclimate.com/github/tongueroo/jack/badges/gpa.svg)](https://codeclimate.com/github/tongueroo/jack)
[![Test Coverage](https://codeclimate.com/github/tongueroo/jack/badges/coverage.svg)](https://codeclimate.com/github/tongueroo/jack)

Jack is a wrapper tool around the [aws eb cli3](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html) tool use to manage AWS Elastic Beanstalk, EB, environments.  It allows you to create environments based on a saved template configuration file, located in the jack/cfg folder of your project.  The jack/cfg files are the same files that are saved by the `eb config save` command, they are simply moved into the jack directory.

Jack also provides a `jack config upload` command to update the EB environment.   Before uploading the configuration to EB jack first downloads the current configuration and then does a diff on the changes that are about to be applied.  This gives a very helpful preview of exactly what you are intending to change.  This is also very helpful when changes are made through the EB GUI and are out of sync with what is stored in the `jack/cfg` files.

For things that this tool does not do, it is recommended that you use use the underlying aws `eb` tool directly.  This tool has been tested with `EB CLI 3.7.6 (Python 2.7.1)`.

## Use Cases

* Downloading EB config to codified the EB infrastructure that has been built.
* Allowing safe uploading of new configs.
* Moving EB enviroments from one EB application to another EB application.  EB provides a way to clone environments within an application but not to another application.

## Installation

```
$ gem install jack-eb
```

Note that the gem is called jack-eb but the command that is installed is called jack.

### Setup

If the version of `eb` that you are using is not working with jack, here is a way to install the specific version jack has been tested with.

<pre>
cd ~/ && wget https://pypi.python.org/packages/source/a/awsebcli/awsebcli-3.7.6.tar.gz
tar -zxvf awsebcli-3.7.6.tar.gz
cd awsebcli-3.7.6
sudo python setup.py install
</pre>

More detail instructions are on [AWS EB Documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-getting-set-up.html).

I typically install the `eb` cli tool with homebrew.

<pre>
brew install awsebcli
</pre>

You will also need to set up your environment with your aws access keys since the tool also uses the aws-sdk.  Add the following to your ~/.profile, replacing xxx with your actually credentials.  Do not forgot to source the ~/.profile or open up a new terminal.

<pre>
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
</pre>

The jack tool does not yet support the `.aws/credentials` method of setting the aws keys.

You're ready to go.

## Usage

### Conventions

Before using the tool, it is good to know that jack follows a convention for the environment and application name.  This is done in order to keep the jack commands simple and short.  The convention is:

<pre>
environment_name: [env]-[app]-[role]
application_name: [app]
</pre>

A concrete example is helpful:

<pre>
environment_name: prod-api-web
application_name: api
</pre>

The example above means the EB application name will be `api` and the environment name will be `prod-api-web`.  The second word of the environment name is by convention the application name.

This convention can be overriden easily via by creating a `~/.jack/settings.yml` or `jack/settings` within the project and defining your own regular expression.  The regexp is a ruby regexp.  Here is an example:

```yaml
create:
  keyname: default
  platform: "64bit Amazon Linux 2015.03 v1.4.0 running Docker 1.6.0"
conventions:
  app_name_pattern: (\w+)-\w+-\w+
```

The default settings are located at [lib/jack/default/settings.yml](https://github.com/tongueroo/jack/blob/master/lib/jack/default/settings.yml).

You can also override the application name convention from the cli with the `--app` flag.  Examples are provided below.

### Overview

You can download a starting baseline jack cfg and use it as template from one of your existing EB environments.

<pre>
$ jack config download [ENVIRONMENT_NAME]
</pre>

The path of config that is saved is based on the environment name.

<pre>
$ jack config download stag-rails-app-s1
Downloading config file...
Running: eb config save --cfg current-2015-03-03_18-40-34 stag-rails-app-s1

Configuration saved at: /Users/tung/src/rails/.elasticbeanstalk/saved_configs/current-2015-03-03_18-40-34.cfg.yml
Writing to local config file: jack/cfg/stag-rails-app-s1.cfg.yml
Cleaning up eb remote config and local files
Config downloaded to jack/cfg/stag-rails-app.cfg.yml
$ 
</pre>

Results in a saved jack/cfg/stag-rails-app-s1.cfg.yml template configuration file.  This saved path is overridable with the `-c` flag. 

<pre>
$ jack config download -c myconfig stag-rails-app-s1
</pre>

Results in a saved `jack/cfg/myconfig.cfg.yml`. 

#### Configuration Templates

Configuration templates hold all the options and settings that we can set for an EB environment.  Elastic Beanstalk surfaces a portion of settings available from the underlying AWS Resources.  These settings include ELB behavior, VPC, LaunchConfiguration, Autoscaling settings, hard drive size, environment variables, etc.

* [Here](https://gist.github.com/tongueroo/acc421c5ec998f238b4b) is an example of all the settings available.
* [Here](https://gist.github.com/tongueroo/f22bbae7864ecec41ff3) is an example of what you would tyically see when you download the initial saved configuration.

### Creating Environments

The purpose of the jack/cfg configs is allow us to be able to create environments with a codified configuration file that can be versioned controlled.

<pre>
$ jack create stag-rails-app-s1 # uses the jack/cfg/stag-rails-app-s1.cfg.yml config
$ jack create stag-rails-app-s2 # uses the jack/cfg/stag-rails-app-s2.cfg.yml config
$ jack create -c myconfig stag-rails-app-s3 # creates environment using jack/cfg/myconfig.cfg.yml
</pre>

If the project is brand new and has never had `eb init` ran on it before.  For example, a project that has just been git cloned.  Then calling any of the jack commands will automatically call `eb init` in the project.  `eb init` requires the platform flag in order to avoid prompting.  The default platform is "64bit Amazon Linux 2015.03 v1.4.0 running Docker 1.6.0".  But you can override that by creating an `~/.jack/settings.yml` or `jack/settings.yml` within the project folder and setting the `create.platform` key.

Here's an [example](https://gist.github.com/tongueroo/086e3c11c4d00d5c39b6). The options from each file is merged and combined together in following order: project folder, user home, [default](lib/jack/default/settings.yml) that is packaged with this gem.

### Downloading and Uploading Template Configurations

#### Download

To download a template configuration.

```
$ jack config download stag-rails-app-s1

$ jack config download stag-rails-app-s1 --app customappname
```

This will save the config to jack/cfg/stag-rails-app-s1.cfg.yml.

#### Upload

To upload a template configuration.

```
$ jack config upload stag-rails-app-s1

$ jack config upload stag-rails-app-s1 --app customappname
```

This will save the config to `jack/cfg/stag-rails-app-s1.cfg.yml`.  

You will notice that the `eb config upload` command prompts you with the diff and asks for confirmation before uploading.  You can bypass the prompt with the force option.

#### Diff - Comparing your local config to the live environment config

You can use the diff command directly to compare your local config to what configs the environment is actually using is useful.  To see the diff.

```
$ jack config diff stag-rails-app-s1
```

A note about the configs.  They are formatted so that the keys are sorted.  This has been done so the diffs are actually useful.  It is also recommended you install colordiff so you can see the diff output colorized.  You can also specify your own diff viewer via the JACK_DIFF environment variable.

### More Help

You can get help information from the CLI.  Examples:

<pre>
$ jack help
$ jack help create
$ jack config help download
$ jack config help upload
$ jack config help sort
</pre>
