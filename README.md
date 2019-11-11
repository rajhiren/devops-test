# devops-test from www.swipejobs.com
 - Findings from Hiren Raj
 - Really appreciate you giving me an opportunity for this test.


# Tell us what you think about the allocated resources and describe, in your own words, your understanding of these
parameters.
  - `hello-world-deploy.yaml` is an example of Deployment. It will create a `ReplicaSet` to bring up a single `devops-test` Pod
  - We are creating a Deployment named `devops-test`, which is indicated by `.metadata.name`
  - The Deployment create a single pod indicated by `replicas` field
  - We are using ramped deployment updates pods in rolling update fashion where `maxSurge` indicates only 1 pod can add at a time and setting `maxUnavailable` to 0 would make sure we have the appropriate capacity during the rolling update.
  - The `template` field contains the following sub-fields:
    - The Pods are labeled `app: devops-test` using the `labels` field.
    - The Pod template’s specification, or `.template.spec` field, indicates that the Pods run one container, `devops:test`
    - this creates one container and name it `devops-hello-world` using the `name` field
  - `imagePullPolicy: Never` indicates that local image is used
  - Container has `memory` of 2GB and it's max limit is also 2GB.
  - We are also telling pod that container is using port `containerPort:8080` for `TCP`
  - for `livenessProbe` and `readinessProbe`
    - The `initialDelaySeconds` field tells the kubelet that it should wait `60` second before performing the first probe.
    - The `periodSeconds` field specifies that the `kubelet` should perform a liveness probe every `1` hour  
  - `volumeMounts` suggests that we have `config-volume` named volume set at pod level and `mountPath` shows mounting path for that directory in our container

  - I was confused that why we have `heap size = 12GB` in Dockerfile but when only initialising `2GB` while creating pod. We need to select same memory size for both.

# Issue with Dockerfile
  - we should never ever use `latest` for `FROM`.
    1. `latest` is not dynamic so it doesn't guarantee that latest is actually the latest version of app
    2. It can be easily overwritten by default
    3. Kubernetes reference docs are very clear on avoiding `latest` tag in our case we should follow that (ref https://kubernetes.io/docs/concepts/configuration/overview/#container-images)

  - we should replace `MAINTAINER` with `LABEL maintainer` because it has been deprecated (ref: https://docs.docker.com/engine/reference/builder/), Also it will help tremendously when using `docker inspect`
  - we can remove `JAVA_OPTS` from `Dockerfile` and assign them into `hello-world-deploy.yaml` file

  - some nice to have changes but not really a deal breaker
    1. use `WORKDIR` so it is easily maintainable for future if we have to change anything. Also, it helps with clarity and reliability of Dockerfile

# Issues with `hello-world-deploy.yaml`
  - We needed to add `selector` so it would match with application template label else it will fail to create pod
  - We have used wrong indentation for `containers.name` so I've fixed that
  - Also we have used wrong `container.image` as we have advised in pdf that `Dockerfile hello-world` would be the image name


# Why do they need to do that simultaneously? What problem could appear if the memory value is modified in only one of those two files above?
  - The only memory reference in Dockerfile is the `heap size` we are defining there, which can be defined in `yaml` file when we can set `env` there and which will avoid changing any memory in Dockerfile. Which means developers still have to come to `devops` to change but at least this way there is only one place to change memory memeory
  
  
 ![alt text] https://raw.githubusercontent.com/rajhiren/devops-test/master/Screen%20Shot%202019-11-10%20at%2023.21.16.png 
  
  
 ![alt text] https://raw.githubusercontent.com/rajhiren/devops-test/master/Screen%20Shot%202019-11-10%20at%2023.23.23.png
