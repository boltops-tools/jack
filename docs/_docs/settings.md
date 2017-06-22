---
title: Settings
---

Some of jack's behavior can be configured by creating a `~/.jack/settings.yml` or `jack/settings.yml` within the project.  The options from the files get merged with the following precedence:

1. current folder - The current folder's `jack/settings.yml` values take the highest precedence.
2. user - The user's `~/.jack/settings.yml` values take the second highest precedence.
3. default - The [default settings](https://github.com/tongueroo/jack/blob/master/lib/jack/default/settings.yml) bundled with the tool takes the lowest precedence.

Let's take a look at an example jack `settings.yml`:

```yaml
create:
  keyname: default
  platform: "64bit Amazon Linux 2017.03 v2.6.0 running Docker 1.12.6"
conventions:
  app_name_pattern: !ruby/regexp /(\w+)-\w+-\w+/
```

The table below covers what each setting does:

Setting  | Description
------------- | -------------
`create.keyname`  | This sets the keyname to use when creating Elastic Beanstalk environment.  This is the ssh key you can use to login into the server.
`create.platform`  | The solution stack to use when launching the EB environment.  You can use `aws elasticbeanstalk list-available-solution-stacks` to get a full list of the available EB solution stacks.  This is covered in more detail below.
`conventions.app_name_pattern`  | This allows you to override the jack naming convention and determines how jack extracts the application name from the environment.  This is covered in detailed in [Conventions]({% link _docs/conventions.md %}).

### Override Convention

Jack follows a convention for the environment and application name.  This is done in order to keep the jack commands simple and short.  The convention is:

<pre>
environment_name: [app]-[role]-[env]
application_name: [app]
</pre>

A concrete example is helpful:

<pre>
environment_name: hi-web-prod
application_name: hi
</pre>

The example above means the EB application name will be `hi` and the environment name will be `hi-web-prod`.  By convention, the first word, separated by a '-', of the environment name is the application name.

This convention can be overridden easily via by configuring the the `conventions.app_name_pattern` setting.  The value is a ruby regexp and must have 1 capture group.  The capture group determines the application name. Here is an example override:

```yaml
create:
  keyname: default
  platform: "64bit Amazon Linux 2016.09 v2.2.0 running Docker 1.11.2"
conventions:
  app_name_pattern: !ruby/regexp /\w+-(\w+)-\w+/
```

In the example above, the capture group is the second word and this will result in:

<pre>
environment_name: prod-hi-web
application_name: hi
</pre>

### Chosing Solution Stack Platform

If the project is brand new and has never had `eb init` ran on it before then calling any of the jack commands will automatically call `eb init` in the project. `eb init` sets the platform and defaults to "64bit Amazon Linux 2017.03 v2.6.0 running Docker 1.12.6". You can override that by setting the `create.platform` key.

<a id="prev" class="btn btn-basic" href="{% link _docs/conventions.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/next-steps.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>
