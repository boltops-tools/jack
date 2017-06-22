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

The diffs are formatted so that their keys are sorted.  This has been done so the diffs are actually useful.  It is also recommended you install colordiff so you can see the diff output colorized.  You can also specify your own diff viewer via the `JACK_DIFF` environment variable.  To use a your own diff viewer, add this to your `~/.profile`:

```sh
$ export JACK_DIFF=colordiff
```

<a id="prev" class="btn btn-basic" href="{% link _docs/jack-apply.md %}">Back</a>
<a id="next" class="btn btn-primary" href="{% link _docs/jack-deploy.md %}">Next Step</a>
<p class="keyboard-tip">Pro tip: Use the <- and -> arrow keys to move back and forward.</p>

