#!/bin/bash

if [ -f ./gen/kind ]; then
    rm ./gen/kind
fi

args="--cpus 3 --memory 8192 --kubernetes-version v1.13.4"

os="$(uname -s)"
case "${os}" in
    Linux*)  minikube start --vm-driver kvm2 $args;;
    Darwin*) minikube start --vm-driver hyperkit $args;;
    *)       echo "Not supported Operating System ${unameOut}"
esac