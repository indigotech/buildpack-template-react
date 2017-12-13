# Taqtile Buildpack for Template React

This was forked from the official [Heroku buildpack](http://devcenter.heroku.com/articles/buildpacks) for Node.js apps.

## Changes made

### Detection

This buildback checks if the app has a `web` folder with `package.json` inside it.

### Compilation

This buildpack uses `web` folder as root for `package.json`.

It has a script that builds local dependencies under `packages` folder and a local dependency from `common`.

The repository containing the app should have a similar structure to this:

```
- common
  - package.json
- packages
  - local-dep1
    - package.json
  - local-dep2
    - package.json
  ...
- web
  - package.json
- Procfile (optional)
```

## Documentation

For more general information about buildpacks on Heroku:

- [Buildpacks](https://devcenter.heroku.com/articles/buildpacks)
- [Buildpack API](https://devcenter.heroku.com/articles/buildpack-api)

## Locking to a buildpack version

In production, you frequently want to lock all of your dependencies - including
buildpacks - to a specific version. That way, you can regularly update and
test them, upgrading with confidence.

First, find the version you want from
[the list of buildpack versions](https://github.com/indigotech/buildpack-template-react/releases).
Then, specify that version with `buildpacks:set`:

```
heroku buildpacks:set https://github.com/indigotech/buildpack-template-react#v83 -a my-app
```

### Chain Node with multiple buildpacks

This buildpack automatically exports node, npm, and any node_modules binaries
into the `$PATH` for easy use in subsequent buildpacks.

## Feedback

Having trouble? Dig it? Feature request?

- [GitHub issues](https://github.com/indigotech/buildpack-template-react/issues)

## Hacking

To make changes to this buildpack, fork it on GitHub.
Push up changes to your fork, then create a new Heroku app to test it,
or configure an existing app to use your buildpack:

```
# Create a new Heroku app that uses your buildpack
heroku create --buildpack <your-github-url>

# Configure an existing Heroku app to use your buildpack
heroku buildpacks:set <your-github-url>

# You can also use a git branch!
heroku buildpacks:set <your-github-url>#your-branch
```

## Tests

The buildpack tests use [Docker](https://www.docker.com/) to simulate
Heroku's Cedar-14 and Heroku-16 containers.

To run the test suite:

```
make test
```

Or to just test in cedar or cedar-14:

```
make test-cedar-14
make test-heroku-16
```

The tests are run via the vendored
[shunit2](https://github.com/kward/shunit2)
test framework.
