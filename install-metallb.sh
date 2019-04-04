#!/bin/bash

KUBE_IP=172.17.0.100 # if using kind & docker

if [ ! -f ./gen/kind ]; then
    KUBE_IP=$(minikube ip)
fi

os="$(uname -s)"
case "${os}" in
    Linux*|Darwin*) sed -s s/YOUR_MINIKUBE_IP/$KUBE_IP/g manifests/metallb/metallb-cm.yaml > manifests/metallb/metallb-cm.effective.yaml;;
    *)       echo "Not supported Operating System ${unameOut}"
             exit 1;;
esac

kubectl apply -f manifests/metallb/metallb-cm.effective.yaml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml