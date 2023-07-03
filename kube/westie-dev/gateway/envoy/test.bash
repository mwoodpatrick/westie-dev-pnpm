minikube start –driver=docker --cpus=2 --memory=2g
kubectl apply -f https://github.com/envoyproxy/gateway/releases/download/v0.2.0/install.yaml
kubectl get pods --namespace gateway-system
kubectl api-resources | grep gateway.networking
kubectl get pods --namespace envoy-gateway-system
kubectl apply -f https://raw.githubusercontent.com/istio/istio/master/samples/httpbin/httpbin.yaml
kubectl get pods -n default
kubectl apply -f gateway_class.yaml
kubectl get gatewayclass -o wide
kubectl apply -f gateway.yaml
kubectl get gateway -o wide
kubectl apply -f http_route.yaml
kubectl get httproute -n default -o wide
kubectl get pods -n envoy-gateway-system
minikube tunnel &
curl --header "Host: www.example.com" 127.0.0.1:8080/headers
