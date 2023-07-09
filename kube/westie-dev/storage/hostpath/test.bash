#!/usr/bin/env bash
# https://www.kubermatic.com/blog/keeping-the-state-of-apps-1-introduction-to-volume-and-volumemounts/
set -x
kubectl create -f hostpath-volume.yaml
kubectl wait -f hostpath-volume.yaml  --for=condition=Ready
kubectl exec  my-hostpath-app -- ls -l /projects/data/foo
kubectl exec  my-hostpath-app -- cat /projects/data/foo
cat /mnt/wsl/projects/data/foo
kubectl delete -f hostpath-volume.yaml
kubectl get pods
