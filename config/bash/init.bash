#!/usr/bin/env sh
# https://nickjanetakis.com/blog/configuring-a-kind-cluster-with-nginx-ingress-using-terraform-and-helm

set -e

cd "$(dirname "$0")/../terraform"

echo "Initializing Terraform... dirname=$PWD"

terraform apply -auto-approve -no-color

printf "\nWaiting for the echo web server service... \n"
kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/usage.yaml
sleep 10

printf "\nYou should see 'foo' as a reponse below (if you do the ingress is working):\n"
curl http://localhost/foo