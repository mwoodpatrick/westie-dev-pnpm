#################################################################################
# MANDATORY SETTINGS for some components. You need to customize these settings #
#################################################################################
#                                                                               #
# In some cases you see two options for the same variable, one of them in       #
# comments. You can always define the value directly in this file, but in some  #
# cases it is better to use an external file, best outside of the scope of a    #
# source control system such as git, so that you don't accidentally put secrets #
# into public places.                                                           #
#                                                                               #
#################################################################################

#
# FEATURE FLAGS: 
# You can enable services that need configuration, Grafana-Cloud and Slack,
# or services that are optional, like Goldilock. External environment settings 
# overwrite configuration here. 
# If you change a config here, it is recommended to restart the cluster with ./start.sh
# to have everything aligned as there are some dependencies (unless you know what you are doing :-))
#
export NGINX_ENABLE="yes"
export KUBERNETES_DASHBOARD_ENABLE="yes"

#
# Projecthome: the environment variable PROJECTHOME must be set to the directory where this config.sh file is located.

cd ${GIT_ROOT}/westie-dev-pnpm/kube/westie-dev
PROJECTHOME=$(dirname $(pwd))

if [ -z ${PROJECTHOME} ]; then
  echo "Please set the PROJECTHOME environment variable to the directory where the config file is."
  echo "use: export PROJECTHOME=/home/user/whereever"
  exit 1
fi

###################################################
# SETTINGS which you usually don't need to change #
###################################################

# K3D Config
export CLUSTER="westie-dev" # Cluster name
export HTTPPORT=8080        # Port for HTTP access to Grafana/Prometheus/Alertmanager in this cluster
export ISTIOPORT=8081       # For for HTTP through Istio
[ -z ${KUBECONFIG} ] && export KUBECONFIG=~/.k3d/kubeconfig-${CLUSTER}.yaml   # the likely KUBECONFIG value

# Helm chart versions
# you can update when you know what you are doing 
INGRESSNGINXCHART="4.0.17"         # see https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
FLUENTBITCHART="0.19.19"           # see https://artifacthub.io/packages/helm/fluent/fluent-bit
NGINXCHART="9.7.6"                 # see https://artifacthub.io/packages/helm/bitnami/nginx

##########################################
# Other settings you don't need to touch #
##########################################

# environment vars for envsubst
ENVSUBSTVAR='$HTTPPORT $CLUSTER'

##########
# CHECKS #
##########

[ -z ${HTTPPORT} ] && echo "$0: missing HTTPPORT definition." && exit 1
[ -z ${CLUSTER} ] && echo "$0: missing CLUSTER definition." && exit 1

if [[ "$(which npx)" == "" ]]; then
  echo "config.sh: we need npx/node/npm installed. but there is no npx... nodejs not installed? "
  exit 1
fi
