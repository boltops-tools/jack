---
title: jack create
---

Run the following command to create an Elastic Beanstalk Environment:

```sh
jack create hi-web-prod
```

The above command will automatically create an Elastic Beanstalk application called **hi** and an environment called **hi-web-prod**.  Jack follows a naming convention scheme: `[app]-[role]-[env]`.  Jack automatically separates the words by dashes and takes the first word using that as the app name.  This is how jack knows how to create an Elastic Beanstalk application named **hi** without you having to tell it that.  The naming convention can be easily [overridden]({% link _docs/conventions.md %}). The naming conventions helps provide guidance for best practices and dramatically simplies the tools usage.  Things just work.

After a few minutes you should see an environment fully spun up in Elastic Beanstalk's Console:

<img src="/img/tutorials/aws-eb-dashboard.png" class="doc-photo" />

In the next step, you'll download the configuration from the newly created environment.

<a class="btn btn-basic" href="{% link _docs/tutorial.md %}">Back</a>
<a class="btn btn-primary" href="{% link _docs/jack-get.md %}">Next Step</a>
