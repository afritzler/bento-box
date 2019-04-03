#!/bin/bash

helm init --upgrade

kubectl apply -f ./manifests/helm/rbac.yaml