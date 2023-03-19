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
echo "==== $0: Various information"
echo "export KUBECONFIG=${KUBECONFIG}"
