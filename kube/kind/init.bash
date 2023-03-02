# https://kind.sigs.k8s.io/docs/user/quick-start

echo "BASH_SOURCE=${BASH_SOURCE[0]}"
export KIND_HOME=`dirname $(realpath ${BASH_SOURCE[0]})`
echo "KIND_HOME=${KIND_HOME}"

function install_kind {
    pushd /tmp || return
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    popd || return
}

function kind_configure {
    export KIND_DIR=${HOME}/.kind

    unset KUBECONFIG
    
    alias kubectl='f(){ sudo kind kubectl "$@";  unset -f f; }; f'

	mkdir -p ${KIND_DIR}

	# check if kind installed
	if ! command -v kind
	then
		# install kind
		install_kind
	fi

	# bash completions

    if [ -f "${KIND_DIR}/bash_completion" ]; then
	    kind completion bash > ${KIND_DIR}/bash_completion
    fi

    . "${KIND_DIR}/bash_completion" # This loads kind bash_completion

    # kind does not provide kubectl install locally

    unalias kubectl 2>/dev/null

}

function kind_dependency_issues {
    # check for any dependency issues
    kind sysinfo|grep -v pass
}

# Check service, logs and kind status
function kind_status {
    kind version
    kind get clusters
    kubectl cluster-info -context kind-kind
	# Access your cluster using kubectl
	kubectl get nodes
}

function kind_update_configuration {
    echo "not implemented"
}

function kind_create_cluster {
    kind create cluster # optionally with --name
}

function kind_create_wsl2_cluster {
    kind create cluster --name kind-wsl2-cluster --kubeconfig wsl-cluster-config.yml
}

function kind_list_clusters {
    kind get clusters
}

function kind_remove {
    kind delete cluster # optionally with --name
}

