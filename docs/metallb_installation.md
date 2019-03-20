# Installing Metallb

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