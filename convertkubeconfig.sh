#!/bin/bash

set +e

cp ./manifests/templates/kubeconfig.template ./kubeconfig

minikube_ip=$(minikube ip)
ca="$(base64 -w 0 $HOME/.minikube/ca.crt)"
cert="$(base64 -w 0 $HOME/.minikube/client.crt)"
cert_key="$(base64 -w 0 $HOME/.minikube/client.key)"

os="$(uname -s)"
case "${os}" in
    Linux*)  sed -i 's/MINIKUBE_IP/'"$minikube_ip"'/g' ./kubeconfig
             sed -i 's/CA/'"$ca"'/g' ./kubeconfig
             sed -i 's/CERT/'"$cert"'/g' ./kubeconfig
             sed -i 's/CKEY/'"$cert_key"'/g' ./kubeconfig;;
    Darwin*) sed -i 's/MINIKUBE_IP/'"$minikube_ip"'/g' ./kubeconfig
             sed -i 's/CA/'"$ca"'/g' ./kubeconfig
             sed -i 's/CERT/'"$cert"'/g' ./kubeconfig
             sed -i 's/CKEY/'"$cert_key"'/g' ./kubeconfig;;
    *)       echo "Not supported Operating System ${unameOut}"
esac