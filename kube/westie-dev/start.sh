#!/bin/bash
set -e

#
# guessing the PROJECTHOME if it is not set
[ -z "${PROJECTHOME}" ] && export PROJECTHOME=$(pwd)

#
# read common settings
source ./config.sh

#
# remove cluster if it exists
if [[ ! -z $(k3d cluster list | grep "^${CLUSTER}") ]]; then
  echo
  echo "KUBERNETES_DASHBOARD_ENABLE: ${KUBERNETES_DASHBOARD_ENABLE} - controls if Kubernetes Dashboard is deployed."
  echo "==== $0: remove existing cluster"
  read -p "K3D cluster \"${CLUSTER}\" exists. Ok to delete it and restart? (y/n) " -n 1 -r
  echo
  if [[ ! ${REPLY} =~ ^[Yy]$ ]]; then
    echo "bailing out..."
    exit 1
  fi
  k3d cluster delete ${CLUSTER}
fi  

echo
echo "==== $0: Create new cluster ${CLUSTER} for app ${APP}:${VERSION}"
cat k3d-config.yaml.template | envsubst "${ENVSUBSTVAR}" > /tmp/k3d-config.yaml
k3d cluster create --config /tmp/k3d-config.yaml
rm /tmp/k3d-config.yaml
export KUBECONFIG=$(k3d kubeconfig write ${CLUSTER})
echo "export KUBECONFIG=${KUBECONFIG}"

echo
echo "==== $0: Loading helm repositories"
if [ "${KUBERNETES_DASHBOARD_ENABLE}" == "yes" ]; then
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard  # kubernetes-dashboard
fi

helm repo update

#
# deploy kubernetes dashboard
if [ "${KUBERNETES_DASHBOARD_ENABLE}" == "yes" ]; then

  #
  # deploy Kubernetes Dashboard
  (cd kubernetes-dashboard; ./kubernetes-dashboard-deploy.sh)

  #
  # get the token for display at the end of this script
  SECRET=$(kubectl get secret -n kubernetes-dashboard | grep kubernetes-dashboard-token- | cut -d " " -f 1)
  TOKEN=$(kubectl -n kubernetes-dashboard describe secret ${SECRET}  | grep ^token | cut -d " " -f 7)

fi

echo 
echo "==== $0: Various information"
echo "export KUBECONFIG=${KUBECONFIG}"
if [ "${KUBERNETES_DASHBOARD_ENABLE}" == "yes" ]; then
  echo "kubernetes dashboard:"
  echo "   visit http://localhost:${HTTPPORT}/dashboard/#/workloads?namespace=_all"
  echo "   use token: ${TOKEN}"
fi
