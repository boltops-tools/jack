---
title: Installation
---

### Install with Bolts Toolbelt

If you want to quickly install jack without having to worry about jack's dependency you can simply install the Bolts Toolbelt which has jack included.

```sh
brew cask install boltopslabs/software/bolts
```

For more information about the Bolts Toolbelt or to get an installer for another operating system visit: [https://boltops.com/toolbelt](https://boltops.com/toolbelt)

### Install with RubyGems

If you prefer to install jack via RubyGems follow the instructions:

```sh
gem install jack-eb # the name is called jack-eb not jack
```

Or you can add jack to your Gemfile in your project if you are working with a ruby project.  It is not required for your project to be a ruby project to use jack.

{% highlight ruby %}
gem "jack-eb"
{% endhighlight %}

You also need to install jack's additional dependencies: the aws cli and the aws eb cli.

On a Mac OS system, you can use homebrew:

```sh
brew install awscli # follow the post install instructions
brew install awsebcli
```

Make sure you follow the homebrew post install instructions to set up  `~/.aws/config` and `~/.aws/credentials`.

On other operating systems, follow Amazon Web Services' official installation guides:

* [Installing the AWS Command Line Interface
](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)
* [Install the Elastic Beanstalk Command Line Interface (EB CLI)](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)


<a class="btn btn-basic" href="/quick-start/">Back</a>
<a class="btn btn-primary" href="{% link _docs/structure.md %}">Next Step</a>
