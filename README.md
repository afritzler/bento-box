# bento-box

![bento box](docs/images/logo.png)

Bento box helps you setting up a local Gardener landscape inside your Minikube without any dependencies to external cloud services like compute, DNS and load balancers.

## Purpose

* Single node, Gardener demo setup
* Local development environment

## Prerequisites

You will need a local Kubernetes setup on your machine.

* Linux
  * [Minikube](https://github.com/kubernetes/minikube) with VirtualBox
  * [Minikube on KVM2](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#kvm2-driver)
  * [kind](https://github.com/kubernetes-sigs/kind)

* MacOS
  * [Minikube](https://github.com/kubernetes/minikube) with VirtualBox
  * [kind](https://github.com/kubernetes-sigs/kind)
  * [Docker for Desktop Kubernetes Environment](https://blog.docker.com/2018/07/kubernetes-is-now-available-in-docker-desktop-stable-channel/)

* [Helm](https://github.com/helm/helm)

## Create a Minikube/Kind box

First we need to create a Minikube environment. Currently the recommended setup is using 8Gb of RAM and 2 CPU. There is a helper script to help you with that.

```bash
./create-minikube.sh
```

Alternatively you can use Kind

```bash
./create-kind.sh
```

## Mutating WebHook

Lets deploy a MutatingAdmissionWebhook into our Minikube setup which will remove all resource limits from incoming objects, so we don't run into `Pending` pods due to missing CPU capacity.

```bash
./install-mutator.sh
```

The mutating webhook is implemented as a Google Cloud Function for now. The code for that can be found [here](https://github.com/afritzler/request-limits-mutator). In future this can be also be moved into the cluster itself.

## Install Kubevirt

In order to create VM instances inside our Minikube we need to install [Kubvirt](https://github.com/kubevirt/kubevirt). The `install-kubevirt.sh` script will help you with that.

```bash
./install_kubevirt.sh
```

Important to note here is, that we are using the user emulation mode in Qemu to avoid running into nested virtualization issues. More information can be found in the [detailed documentation](docs/kubevirt_installation.md).

## Setup MetalLB

In order to handle service objects of type `LoadBalancer` we will be using [metallb](https://github.com/google/metallb) in layer-2 mode. To install metallb into your minikube and configure the correct IP range run

```bash
./install-metallb.sh
```

More information on the metallb configuration and setup can be found [here](docs/metallb_installation.md).

## Install Nginx-Ingress-Controller

Since we will use the Minikube box as a seed cluster, we need to install an nginx-ingress controller

```bash
./install-nginx-ingress.sh
```

## Install Helm

Since we need helm to install the Gardener helm chart

```bash
./install-helm.sh
```

## Install Gardener

To bring up the Gardener API server and Controller Manager

```bash
./install-gardener.sh
```

## Configure Seed, CloudProfile, etc.

(Only for Minikube) The setup is finished up by registering Minikube as our seed, deploying the Kubevirt cloudprofile and put the secrets in place. Since we can't use the Minikube `kubeconfig` which is located under `~/.kube/config` (please don't use merged kubeconfigs here) - we need to convert it the corresponding format.

```bash
./convertkubeconfig.sh
```

Now we can warp up the configuration with

```bash
./configure-gardener.sh
```

## Deploy a Shoot

A sample shoot spec can be found under `manifests/examples/shoot.yaml`. To create a shoot cluster in our Minikube box run

```bash
kubectl apply -f manifests/examples/shoot.yaml
```

## Cleanup

To remove the whole setup just run

```bash
minikube delete
```