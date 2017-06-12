---
title: Structure
---

The ElasticBeanstalk configuration files are downloaded and stored in the `jack/cfg` folder within the project.  Here's a example of the structure with some downloaded Elastic Beankstalk environment configurations.

```sh
jack
└── cfg
    ├── hi-web-prod.cfg.yml
    └── hi-web-stag.cfg.yml
```

#### Configuration File Details

Let's take a look at one of the configuration files `jack/cfg/hi-web-stag.cfg.yml`:

{% highlight yaml %}

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
  aws:elasticbeanstalk:application:environment:
    RAILS_ENV: staging
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
{% endhighlight %}

The configuration file provides everything that is required to rebuild the Elastic Beanstalk environment.

Now that you now where the jack configurations are located and what they look like.  Let use it!

<a class="btn btn-basic" href="{% link _docs/install.md %}">Back</a>
<a class="btn btn-primary" href="{% link _docs/tutorial.md %}">Next Step</a>
