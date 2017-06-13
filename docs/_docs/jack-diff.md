---
title: jack diff
---

#### Preview Changes

You can preview the changes without applying the changes with `jack diff`.

```sh
jack diff hi-web-stag
```

You should see something similar to this:

<img src="/img/tutorials/jack-diff.png" class="doc-photo" />

By default, `jack diff` cleans up after itself and removes the originally downloaded `.elasticbeanstalk/saved_configs`.  If you would like to keep that file around for further inspection, use the `--dirty` flag.

```sh
jack diff hi-web-stag --dirty
```

<a id="prev" class="btn btn-basic" href="{% link _docs/jack-apply.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/jack-deploy.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>
