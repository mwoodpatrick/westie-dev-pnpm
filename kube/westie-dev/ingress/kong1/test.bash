# https://minikube.sigs.k8s.io/docs/handbook/addons/kong-ingress/

k apply -f echo_service.yaml
k apply -f kong_ingress.yaml
k get ingress
curl -i localhost/echo -H "Host: kong.example"
