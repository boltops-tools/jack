---
title: jack get
---

Run the following command to download the configuration from the Elastic Beanstalk environment:

```sh
jack get hi-web-stag
```

You should see something similar to this:

<img src="/img/tutorials/jack-get.png" class="doc-photo" />

Let's take a look the contents of the downloaded file:

```yaml
AWSConfigurationTemplateVersion: 1.1.0.0
EnvironmentConfigurationMetadata:
  Description: Configuration created from the EB CLI using "eb config save".
EnvironmentTier:
  Name: WebServer
  Type: Standard
OptionSettings:
  aws:autoscaling:launchconfiguration:
    EC2KeyName: default
    IamInstanceProfile: aws-elasticbeanstalk-ec2-role
    InstanceType: t2.micro
  aws:autoscaling:updatepolicy:rollingupdate:
    RollingUpdateEnabled: true
    RollingUpdateType: Health
  aws:elasticbeanstalk:command:
    BatchSize: '30'
    BatchSizeType: Percentage
  aws:elasticbeanstalk:environment:
    ServiceRole: aws-elasticbeanstalk-service-role
  aws:elasticbeanstalk:healthreporting:system:
    SystemType: enhanced
  aws:elb:loadbalancer:
    CrossZone: true
  aws:elb:policies:
    ConnectionDrainingEnabled: true
Platform:
  PlatformArn: arn:aws:elasticbeanstalk:us-west-2::platform/Docker running on 64bit
    Amazon Linux/2.1.0
```

As you can see the configuration file contains everything there is to know about the Elastic Beanstalk environment.  These settings include ELB behavior, VPC, LaunchConfiguration, AutoScaling settings, hard drive size, environment variables, etc.  With this file you can completely rebuild the environment and even "clone" it across Elastic Beanstalk applications.

If you would like to save the config file under a different path, you can use the `-c` option.

```sh
jack get hi-web-stag -c my-config
```

This saves the config file to `jack/cfg/my-config.cfg.yml`.  You can also override which config file to use with the `-c` flag when creating EB environments like so:

```sh
jack create hi-web-stag-2 -c my-config
```

If you would like to override the application name convention you can use the `--app` option.

```sh
jack create hi-web-stag-2 --app myapp
```


<a id="prev" class="btn btn-basic" href="{% link _docs/jack-create.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/jack-apply.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

