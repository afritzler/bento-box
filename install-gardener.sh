#!/bin/bash

if [ -d gardener ]; then
    (
        cd gardener
        git pull origin master
    )
else
    git clone https://github.com/kubeforge/gardener.git
fi

helm install --name gardener --namespace garden -f manifests/gardener/local-values.yaml gardener/charts/gardener --replace