#!/bin/sh

set -o errexit
set -o nounset

cd "$(dirname -- "$0")"
helm install --hide-notes --create-namespace --namespace argocd argo-cd \
  --repo https://argoproj.github.io/argo-helm argo-cd --version 7.8.2 \
  --values argo-cd-values.yaml --wait
kubectl create namespace demo-app
kubectl create secret generic --namespace demo-app regcred \
  --from-file=.dockerconfigjson=docker-config.json --type=kubernetes.io/dockerconfigjson
kubectl apply --filename apps.yaml
