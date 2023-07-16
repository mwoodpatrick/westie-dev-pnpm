# https://k3d.io/v5.0.1/usage/exposing_services Ingress
set -x
# configure k3s‘s API-Server listening on port 6550 with that port mapped to the host system.
# all ports exposed on the serverlb will be proxied to the same ports on all server nodes in the cluster
# Map port 80 on loadbalancer to localhost:8081
# Docker shows:
# c1247ddbba37   ghcr.io/k3d-io/k3d-proxy:5.5.1   "/bin/sh -c nginx-pr…"   2 minutes ago   Up 2 minutes   0.0.0.0:8081->80/tcp, :::8081->80/tcp, 0.0.0.0:6550->6443/tcp     k3d-k3s-default-serverlb
k3d cluster create --api-port 6550 -p "8081:80@loadbalancer" --agents 2 --wait

# Create a nginx deployment 
kubectl create deployment nginx --image=nginx

# Create a ClusterIP service for it

kubectl create service clusterip nginx --tcp=80:80

# create an ingress object

kubectl apply -f ingress_route.yaml

# wait on ingress to be ready
# kubectl wait --for=condition=ready svc -l app=nginx

ip=""
while [ -z $ip ]; do
  echo "Waiting for external IP"
  ip=$(kubectl get ingress/nginx --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")
  [ -z "$ip" ] && sleep 10
done
echo 'Found external IP: '$ip

docker ps
kubectl get nodes
kubectl get svc
kubectl get ingress/nginx

# Use curl to access the nginx web app

until curl --fail localhost:8081/
do
  sleep 0.1
done

set +x
