#!/usr/bin/env bash
# Envoy Gateway Release: v0.4.0
# https://gateway.envoyproxy.io/v0.4.0/user/quickstart.html

# set -x

function delete-all {
    minikube delete --all
}

function envoy_gateway_install {
    # minikube start
    helm install eg oci://docker.io/envoyproxy/gateway-helm --version v0.4.0 -n envoy-gateway-system --create-namespace
    helm status eg -n envoy-gateway-system
    kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available
    kubectl apply -f https://github.com/envoyproxy/gateway/releases/download/v0.4.0/quickstart.yaml -n default
    kubectl wait deployment.apps/backend --for=condition=Available
    kubectl get svc -n envoy-gateway-system
    export ENVOY_SERVICE=$(kubectl get svc -n envoy-gateway-system --selector=gateway.envoyproxy.io/owning-gateway-namespace=default,gateway.envoyproxy.io/owning-gateway-name=eg -o jsonpath='{.items[0].metadata.name}')
    echo "ENVOY_SERVICE=$ENVOY_SERVICE"
    kubectl -n envoy-gateway-system port-forward service/${ENVOY_SERVICE} 8888:80 &
    export TUNNEL_PID=$!
    echo "tunnel pid=$TUNNEL_PID"
    curl --verbose --header "Host: www.example.com" http://localhost:8888/get
}
