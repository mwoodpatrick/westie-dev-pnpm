kubectl create -f emptyDir.yaml
kubectl get pods
kubectl describe pod/my-empty-app
kubectl exec -it my-empty-app -- bash
