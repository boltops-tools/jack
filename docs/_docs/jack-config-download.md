---
title: jack get
---

Run the following command to download the configuration from the Elastic Beanstalk environment:

```sh
jack get hi-web-stag
```

You should something similar to this:

<img src="/img/tutorials/jack-config-download.png" class="doc-photo" />

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

As you can see this file contains everything there is to know about the Elastic Beanstalk environment.  With this file you can completely rebuild the environment and even "clone" it across Elastic Beanstalk applications.

<a class="btn btn-basic" href="{% link _docs/jack-create.md %}">Back</a>
<a class="btn btn-primary" href="{% link _docs/jack-config-upload.md %}">Next Step</a>
