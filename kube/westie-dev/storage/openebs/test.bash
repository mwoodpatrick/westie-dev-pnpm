kubectl apply -f https://openebs.github.io/charts/examples/local-hostpath/local-hostpath-pvc.yaml
kubectl apply -f https://openebs.github.io/charts/examples/local-hostpath/local-hostpath-pod.yaml
kubectl get pod hello-local-hostpath-pod
kubectl get pvc local-hostpath-pvc
# minikube ssh
# cd /var/openebs/local/pvc-ec8d86c3-1c2b-4523-8257-6347768f8e37/
# touch fred.txt
