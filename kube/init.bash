# kubernetes setup

# [Install and Set Up kubectl on Linux]( https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
function kubectl_download_and_install {
    unalias kubectl 2>/dev/null

    pushd /tmp || return

	if ! command -v kubectl
	then
		# download kubectl

		curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

		# download kubectl checksum

        curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

        # verify the download
        if echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check ; then
            # install kubectl
            sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

            # get client version
            kubectl version --short --client
        fi
	fi

    popd || return

    # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
    source <(kubectl completion bash) 
}

function kubernetes_status {
    kubectl version --short
    # [kubernetes: change the current/default context via kubectl command](https://stackoverflow.com/questions/70258039/kubernetes-change-the-current-default-context-via-kubectl-command)
    kubectl config get-contexts
	kubectl get all -A
}

# Krew is the plugin manager for kubectl command-line tool.
# https://krew.sigs.k8s.io/
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
function install_krew {
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
}

source <(kubectl krew completion bash) 

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# [kubectl-plugins](https://github.com/luksa/kubectl-plugins)
export PATH=$GIT_ROOT/westie-dev-pnpm/kube/kubectl/plugins/luksa_kubectl-plugins:${PATH}

source ${GIT_ROOT}/westie-dev-pnpm/kube/k0s/init.bash
source ${GIT_ROOT}/westie-dev-pnpm/kube/k3s/init.bash
source ${GIT_ROOT}/westie-dev-pnpm/minikube/k3s/init.bash

# possibly use /home/mwoodpatrick/.kube/config instead
if [ -z "$KUBECONFIG" ]; then
    export KUBECONFIG="$MONOREPO_ROOT"/kube/admin.conf
fi
echo "KUBECONFIG=$KUBECONFIG"

