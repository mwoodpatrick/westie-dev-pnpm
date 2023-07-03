#!/usr/bin/env bash
# Test Kong Ingress
# https://minikube.sigs.k8s.io/docs/handbook/addons/kong-ingress/

NS=test-kong
kubectl create namespace $NS
kubectl --namespace $NS apply -f kong_ingress.yaml
kubectl --namespace $NS get ingress
sleep 5
curl -i localhost/echo -H "Host: kong.example"
kubectl --namespace $NS delete -f kong_ingress.yaml
kubectl --namespace $NS delete -f echo_service.yaml
kubectl delete namespace $NS
