# https://docs.k3s.io/quick-start

echo "BASH_SOURCE=${BASH_SOURCE[0]}"
export K3S_HOME=$(dirname $(realpath ${BASH_SOURCE[0]}))
echo "K3S_HOME=${K3S_HOME}"

function k3s_configure {
	export K3S_DIR=${HOME}/.k3s

	unset KUBECONFIG

	alias kubectl='f(){ sudo k3s kubectl "$@";  unset -f f; }; f'

	mkdir -p ${K3S_DIR}

	# check if k3s installed
	if ! command -v k3s; then
		# install k3s
		curl -sfL https://get.k3s.io | sh -
	fi

	# create bash completions

	if [ -f "${K3S_DIR}/bash_completion" ]; then
		k3s completion bash >${K3S_DIR}/bash_completion
	fi

	. "${K3S_DIR}/bash_completion" # This loads k3s bash_completion
}

function k3s_dependency_issues {
	# check for any dependency issues
	k3s sysinfo | grep -v pass
}

# Check service, logs and k3s status
function k3s_status {
	# Access your cluster using kubectl
	kubectl get nodes
}

function k3s_update_configuration {
	echo "not implemented"
}

function k3s_remove {
	echo "not implemented"
}

function k3s_list_containers {
	# add -a to include stopped containers
	sudo k3s crictl ps
}
