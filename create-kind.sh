#!/bin/bash

kind create cluster

# move kubeconfig in place
cp $(kind get kubeconfig-path) ./kubeconfig

mkdir -p ./gen
touch ./gen/kind