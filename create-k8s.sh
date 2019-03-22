#!/bin/bash

os="$(uname -s)"
case "${os}" in
    Linux*)  minikube start --vm-driver kvm2 --cpus 2 --memory 8192;;
    Darwin*) minikube start --vm-driver hyperkit --memory 8192;;
    *)       echo "Not supported Operating System ${unameOut}"
esac