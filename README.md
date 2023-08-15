[![Docker Pulls](https://badgen.net/docker/pulls/saslanov/runner-container-dss?icon=docker&label=pulls)](https://hub.docker.com/r/saslanov/runner-container-dss)
[![Docker Stars](https://badgen.net/docker/stars/saslanov/runner-container-dss?icon=docker&label=stars)](https://hub.docker.com/r/saslanov/runner-container-dss)
![GHA Workflow](https://github.com/saslanov94/runner-container-dss/actions/workflows/build_dss.yaml/badge.svg)

# runner-container-dss

This is a Docker image for Github Actions used to connect to Dataiku DSS instances via Dataiku's Python client.

# Usage

```
jobs:
  my_random_job:
    name: my_random_job
    runs-on: ubuntu-latest
    container:
      image: saslanov/runner-container-dss:version
```
