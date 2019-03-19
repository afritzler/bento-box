# gardener-kubevirt-local

## Setup Minikube with KVM2 (Linux)

## Setup Minikube with Hyperkit (MacOS)

## Install Kubevirt

```bash
export VERSION=v0.15.0
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERSION/kubevirt-operator.yaml
# enable emulation mode for libVirt
kubectl create configmap kubevirt-config -n kubevirt --from-literal debug.useEmulation=true
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERION/kubevirt-cr.yaml
```

## Setup Metal-LB

Adjust the address pool for metal-lb by using the Minikube's IP address as the first
address in the pool. You can find out Minikube's IP address by running `minikube ip`.

```bash
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: custom-ip-space
      protocol: layer2
      addresses:
      - <MY_MINIKUBE_IP_ADDRESS>/32
```

Install metal-lb into you minkube.

```bash
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
```