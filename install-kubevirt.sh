#!/bin/bash

export VERSION=v0.15.0
#kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERSION/kubevirt-operator.yaml
kubectl create ns kubevirt
# enable emulation mode for libVirt
kubectl apply -f manifests/kubevirt/kubevirt-cm.yaml
kubectl apply -f manifests/kubevirt/kubevirt-operator.yaml

sleep 5
kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/$VERSION/kubevirt-cr.yaml

kubectl create ns vms