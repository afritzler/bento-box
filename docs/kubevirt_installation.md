# Installing Kubevirt

Some details will follow here ...

```bash
export VERSION=v0.15.0
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERSION/kubevirt-operator.yaml
# enable emulation mode for libVirt
kubectl create configmap kubevirt-config -n kubevirt --from-literal debug.useEmulation=true
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERSION/kubevirt-cr.yaml
```