A container which waits for a webhook to be called, after which it builds a site using zola.

* git clones site & submodules
* supports git-lfs assets
* webhook is unauthenticated, simple Flask app which calls a shell script

# configure repo

```
cp .env-sample .env
```
and change it to point to your repo & branch you want to build

# configure ssh

```
mkdir ssh_keys
# put your key in there, or generate a new one for the container to use
```

you need to add any git host that will be cloned from, to known_hosts. you can accomplish this by interactively running /on_request.sh once inside the container, or:

```
ssh-keyscan $host >> ssh_keys/known_hosts
```

# troubleshooting

* zola runs as uid 1000, check that the output directory and ssh keys are readable
* try running the action handler interactively: `docker-compose exec zola-builder /on_request.sh`

# todos

* minimum time between builds
* require a secret from the webhook call before starting a build
