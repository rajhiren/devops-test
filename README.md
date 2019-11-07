# devops-test
test for devops

# Answers

# Issue with Dockerfile
  - we should never ever use `latest` for `FROM`.
    1. `latest` is not dynamic so it doesn't guarantee that latest is actually the latest version of app
    2. It can be easily overwritten by default
    3. Kubernetes reference docs are very clear on avoiding `latest` tag in our case we should follow that (ref https://kubernetes.io/docs/concepts/configuration/overview/#container-images)

  - we should replace `MAINTAINER` with `LABEL maintainer` because it has been deprecated (ref: https://docs.docker.com/engine/reference/builder/), Also it will help tremendously when using `docker inspect`

  - some nice to have changes but not really a deal breaker
    1. use `WORKDIR` so it is easily maintainable for future if we have to change anything. Also, it helps with clarity and reliability of Dockerfile
