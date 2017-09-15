---
title: Installation
---

### Install with RubyGems

You can install jack via RubyGems:

```sh
gem install jack-eb # the name is called jack-eb not jack
```

You can also add jack to your Gemfile in your project if you are working with a ruby project.  It is not required for your project to be a ruby project to use jack.

{% highlight ruby %}
gem "jack-eb"
{% endhighlight %}

#### Additional Depedencies

If you are installing jack via RubyGems, you will also need to install jack's additional dependencies: the [aws cli](https://aws.amazon.com/documentation/cli/) and the [aws eb cli3](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html).  If you have used the bolts installer then you do not have to worry about installing these additional dependencies.

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

### Install with Bolts Toolbelt

If you want to quickly install jack without having to worry about jack's dependency you can install the Bolts Toolbelt which has jack included.

```sh
brew cask install boltopslabs/software/bolts
```

The bolts installer will also automatically install the [aws cli](https://aws.amazon.com/documentation/cli/) and the [aws eb cli3](http://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3.html) dependencies for you.  You don't have to worry about it!

For more information about the Bolts Toolbelt or to get an installer for another operating system visit: [https://boltops.com/toolbelt](https://boltops.com/toolbelt)


<a id="prev" class="btn btn-basic" href="{% link docs.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/structure.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

