#!/usr/bin/env bash
# https://minikube.sigs.k8s.io/docs/handbook/addons/kong-ingress/

# which bash
# alias
NS=test-kong
k create namespace $NS
k --namespace $NS apply -f echo_service.yaml
k --namespace $NS apply -f kong_ingress.yaml
k --namespace $NS get ingress
sleep 5
curl -i localhost/echo -H "Host: kong.example"
k --namespace $NS delete -f kong_ingress.yaml
k --namespace $NS delete -f echo_service.yaml
k delete namespace $NS
