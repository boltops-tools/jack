# Jack and the Elastic Beanstalk

[![Build Status](https://travis-ci.org/tongueroo/jack.svg?branch=master)](https://travis-ci.org/tongueroo/jack)
[![Code Climate](https://codeclimate.com/github/tongueroo/jack/badges/gpa.svg)](https://codeclimate.com/github/tongueroo/jack)
[![Test Coverage](https://codeclimate.com/github/tongueroo/jack/badges/coverage.svg)](https://codeclimate.com/github/tongueroo/jack)

Jack is a wrapper tool around the eb cli tool that can be use to manage AWS Elastic Beanstalk environments.  It allows you to create environments based on a saved template configuration file, located in the jack/cfg folder of your project.  It also provides a helpful config command to manage the template configuration. 

For things that this tool does not do, it is recommended that you use use the underlying eb tool directly.  This tool uses version 3.1.2 of the eb command.

## Installation

```
$ gem install jack-eb
```

Note that the gem is called jack-eb but the command that is installed is called jack.

### Setup

This gem relies on the eb cli tool.  To install follow the instructions on [AWS EB Documentation](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-getting-set-up.html).  Here's the gist of it:

<pre>
$ sudo pip install awsebcli
</pre>

You need at least version 3.1.2 of the eb tool.  To check the version `eb --version`.  If you need to upgrade:

<pre>
$ sudo pip install --upgrade awsebcli
</pre>

You'll also need to set up your environment with your aws access keys since the tool also uses the aws-sdk.  Add the following to your ~/.profile, replacing xxx with your actually credentials.  Don't forgot to source the ~/.profile or open up a new terminal.

<pre>
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=xxx
</pre>

You're ready to go.

## Usage

### Overview

In your project folder create a folder call jack/cfg.  It might be useful for your company to create a baseline config that you can use.  If you do not already have a baseline template, you can download the template from an existing environment like so:

<pre>
$ jack config download [ENVIRONMENT_NAME]
</pre>

The path of config that is saved is based on a convention.  An example best illustrates the convention.

<pre>
$ jack config download stag-rails-app-s1
Downloading config file...
Running: eb config save --cfg current-2015-03-03_18-40-34 stag-rails-app-s1

Configuration saved at: /Users/tung/src/rails/.elasticbeanstalk/saved_configs/current-2015-03-03_18-40-34.cfg.yml
Writing to local config file: jack/cfg/stag-rails-app.cfg.yml
Cleaning up eb remote config and local files
Config downloaded to jack/cfg/stag-rails-app.cfg.yml
$ 
</pre>

Results in a saved jack/cfg/stag-rails-app.cfg.yml template configuration file.  Notice how the last dash separated word has been removed.  The convention is overridable. 

<pre>
$ jack config download -c myconfig stag-rails-app-s1
</pre>

Results in a saved jack/cfg/myconfig.cfg.yml template configuration file. 

### Creating Environments

The purpose of the jack/cfg configs is allow us to be able to create environments with a codified configuration file that can be versioned controlled.

<pre>
$ jack create stag-rails-app-s1 # uses the jack/cfg/stag-rails-app.cfg.yml template
$ jack create stag-rails-app-s2 # another instance of the environment, but still uses the jack/cfg/stag-rails-app.cfg.yml template
$ jack create -c myconfig stag-rails-app-s3 # creates environment using a config not based on naming convention
</pre>

If the project is brand new and has never had `eb init` ran on it before.  For example, a project that has just been git cloned.  Then calling any of the jack commands will automatically call `eb init` in the project.  `eb init` requires the platform flag in order to avoid prompting.  By default, the latest Docker solution stack is used for the platform option.  But you can override that by creating an ~/.jack/create.yml or jack/create.yml within the project folder.  Here's an [example](https://gist.github.com/tongueroo/086e3c11c4d00d5c39b6). The options from each file is merged using the following precedence: project folder, user home, default that is packaged with this gem.  Most of the settings that `jack create` should used should be in the template configuration file though.

### Downloading and Uploading Template Configurations

#### Download

To download a template configuration.

```
$ jack config download stag-rails-app-s1
```

This will save the config to jack/cfg/stag-rails-app.cfg.yml.

#### Upload

To upload a template configuration.

```
$ jack config upload stag-rails-app-s1
```

This will save the config to jack/cfg/stag-rails-app.cfg.yml.  Here's an example of the [output](http://d.pr/i/14Sfh).

Notice that the `eb config upload` command also prompts you with the diff before uploading and ask for confirmation.  You can bypass the prompt with the force option.

#### Diff - Comparing your local config to the live environment config

You can use the diff command directly to compare your local config to what configs the environment is actually using is useful.  To see the diff.  

```
$ jack config diff stag-rails-app-s1
```

A note about the configs.  They are formatted so that the keys are sorted.  This has been done so the diffs are actually useful.  It is also recommended you install colordiff so you can see the diff output colorized.  You can also specify your own diff viewer via the JACK_DIFF environment variable.  Example of [colorized diff](http://d.pr/i/9wrS).

### More Help

You can get help information from the CLI.  Examples:

<pre>
$ jack help
$ jack help create
$ jack config help download
$ jack config help upload
$ jack config help upload
$ jack config help sort
</pre>

### TODO

* encrypted the jack/cfg files similar to how [shopify/ejson](https://github.com/Shopify/ejson) works, except with yaml - pull requests are welcome
