#!/usr/bin/env bash
# Install OpenEBS
# https://openebs.io/docs/user-guides/localpv-hostpath

helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace openebs openebs/openebs --create-namespace

kubectl get storageclasses

kubectl apply -f https://openebs.github.io/charts/examples/local-hostpath/local-hostpath-pvc.yaml
kubectl apply -f https://openebs.github.io/charts/examples/local-hostpath/local-hostpath-pod.yaml
kubectl get pod hello-local-hostpath-pod
kubectl get pvc local-hostpath-pvc
# minikube ssh
# cd /var/openebs/local/pvc-ec8d86c3-1c2b-4523-8257-6347768f8e37/
# touch fred.txt
