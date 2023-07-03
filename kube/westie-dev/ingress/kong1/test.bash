#!/usr/bin/env bash
# Test Kong Ingress
# https://minikube.sigs.k8s.io/docs/handbook/addons/kong-ingress/

PROFILE=minikube-dev
NS=test-kong

kubectl create namespace $NS
minikube -p $PROFILE tunnel &
TUNNEL_PID=$!
echo "tunnel pid=$TUNNEL_PID"
minikube -p $PROFILE addons enable kong
minikube -p $PROFILE addons list
kubectl --namespace $NS apply -f echo_service.yaml
kubectl --namespace $NS wait deployment.apps/echo --for condition=available
kubectl --namespace $NS apply -f kong_ingress.yaml
sleep 5
kubectl --namespace $NS get all
kubectl --namespace $NS get ingress
curl -i localhost/echo -H "Host: kong.example"
kubectl --namespace $NS delete -f kong_ingress.yaml
kubectl --namespace $NS delete -f echo_service.yaml
kubectl delete namespace $NS
minikube -p $PROFILE addons disable kong
minikube -p $PROFILE addons list
kill -TERM $TUNNEL_PID
