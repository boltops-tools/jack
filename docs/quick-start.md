---
title: Quick Start
---

In a hurry? No problem!  Here's a quick start to using jack that takes only a few minutes.  The commands below creates a sample Elastic Beanstak environment. It then demonstrates how to use jack to download the infrastructure configurations so you can save them into version control.  You make some changes to the configuration file and then upload it back to the EB environment.

```sh
brew cask install boltopslabs/software/bolts
mkdir hi
cd hi
jack create hi-web-stag # creates a EB App named hi and EB Environment named hi-web-stag
jack download hi-web-stag
# ... make adjustments to jack/cfg/hi-web-stag.yml ...
jack upload hi-web-stag
```

Congratulations!  You have successfully created a Elastic Beanstalk environment, downloaded the config and uploaded the config. It was really that simple 😁

Learn more in the next sections.

<a id="next" class="btn btn-primary" href="{% link docs.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

