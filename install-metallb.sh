#!/bin/bash

MINIKUBE_IP=$(minikube ip)
sed -s s/YOUR_MINIKUBE_IP/$MINIKUBE_IP/g manifests/metallb-cm.yaml > manifests/metallb-cm.effective.yaml

kubectl apply -f manifests/metallb-cm.effective.yaml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
