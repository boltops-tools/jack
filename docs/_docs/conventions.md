---
title: Installation
---

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

This convention can be overridden easily via by creating a `~/.jack/settings.yml` or `jack/settings.yml` within the project and defining your own regular expression with the `conventions.app_name_pattern` key.  The regexp is a ruby regexp and must have 1 capture group.  The capture group is used to determine the application name. Here is an example:

```yaml
create:
  keyname: default
  platform: "64bit Amazon Linux 2017.03 v2.6.0 running Docker 1.12.6"
conventions:
  app_name_pattern: !ruby/regexp /\w+-(\w+)-\w+/
```

In the example above, the capture group is the second word and this will result in:

<pre>
environment_name: prod-hi-web
application_name: hi
</pre>


The default setting is located at [lib/jack/default/settings.yml](https://github.com/tongueroo/jack/blob/master/lib/jack/default/settings.yml).

You can also override the application name convention from the cli with the `--app` flag.  Examples are provided below.



<a id="prev" class="btn btn-basic" href="{% link _docs/jack-help.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/settings.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

