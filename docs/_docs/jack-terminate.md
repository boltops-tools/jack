---
title: jack terminate
---

Let's clean up after ourselves and delete the environment.  You can delete your Elastic Beanstalk environment with the following command:

```sh
jack terminate hi-web-stag
```

Jack prompts you for confirmation.  If you want to bypass the prompt use the `--sure` flag.

```
jack terminate hi-web-stag --sure
```

Congratulations! 🍾 You have created Elastic Beanstalk environments, downloaded and applied configuration changes, deployed new code to the environment and cleaned up after youself by terminating the environment. You have successfully used jack to manage an Elastic Beanstalk environment.

<a class="btn btn-basic" href="{% link _docs/jack-deploy.md %}">Back</a>
<a class="btn btn-primary" href="{% link _docs/next-steps.md %}">Next Step</a>
