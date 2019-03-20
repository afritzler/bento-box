![bento box](docs/images/logo.png)

# bento-box

Setup a local Gardener landscape inside your Minikube without any dependencies to external cloud services like compute, DNS and load balancers.

## Prerequisites

* [Minikube](https://github.com/kubernetes/minikube) on Mac/Linux
  * [Setup Minikube with KVM2 (Linux)](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#kvm2-driver)
  * [Setup Minikube with Hyperkit (MacOS)](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperkit-driver)

## Install Kubevirt

In order to create VM instances inside our Minikube we need to install [Kubvirt](https://github.com/kubevirt/kubevirt). The `install-kubevirt.sh` script will help you with that.

```bash
./install_kubevirt.sh
```

Important to note here is, that we are using the user emulation mode in Qemu to avoid running into nested virtualization issues. More information can be found in the [detailed documentation](docs/kubevirt_installation.md).

## Setup Metal-LB

