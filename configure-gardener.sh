#!/bin/bash

set +e

mkdir -p ./gen

# put the manifests in place
cp ./manifests/gardener-config/* ./gen
cp ./manifests/templates/seed.yaml ./gen/50-seed.yaml
cp ./manifests/templates/seed-secret.yaml.template ./gen/40-seed-secret.yaml
cp ./manifests/templates/core-secret.yaml.template ./gen/70-core-secret.yaml

kubeconfig="$(base64 -w 0 ./kubeconfig)"
ingressip="$(kubectl -n nginx-ingress get svc nginx-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"

os="$(uname -s)"
case "${os}" in
    Linux*)  sed -i 's/INGRESSIP/'"$ingressip"'/g' ./gen/50-seed.yaml
             sed -i 's/KUBECONFIG/'"$kubeconfig"'/g' ./gen/40-seed-secret.yaml
             sed -i 's/KUBECONFIG/'"$kubeconfig"'/g' ./gen/70-core-secret.yaml;;
    Darwin*) sed -i 's/INGRESSIP/'"$ingressip"'/g' ./gen/50-seed.yaml
             sed -i 's/KUBECONFIG/'"$kubeconfig"'/g' ./gen/40-seed-secret.yaml
             sed -i 's/KUBECONFIG/'"$kubeconfig"'/g' ./gen/70-core-secret.yaml;;
    *)       echo "Not supported Operating System ${unameOut}"
esac

kubectl apply -f ./gen/