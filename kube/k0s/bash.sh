# [Deploy Kubernetes Cluster on Linux With k0s](https://computingforgeeks.com/deploy-kubernetes-cluster-on-linux-with-k0s/)
# [k0s | Kubernetes distribution for bare-metal, on-prem, edge, IoT (k0sproject.io)](https://k0sproject.io/)
# [Documentation (k0sproject.io)](https://docs.k0sproject.io/v1.26.1+k0s.0/)
# [k0sproject/k0s: k0s - The Zero Friction Kubernetes (github.com)](https://github.com/k0sproject/k0s)
# [k0s vs k3s - Search (bing.com)](https://www.bing.com/search?q=k0s+vs+k3s&form=ANNTH1&refig=4d041ab62acb4b2584a82f8beea6f252&sp=1&qs=LT&pq=k0s+&sc=10-4&cvid=4d041ab62acb4b2584a82f8beea6f252)

export K0S_DIR=${HOME}/.k0s
[ -s "$K0S_DIR/nvm.sh" ] && \. "$K0S_DIR/bash.sh"                  # This installs k0s
[ -s "$K0S_DIR/bash_completion" ] && \. "$K0S_DIR/bash_completion" # This loads k0s bash_completion

function k0s_install {
	mkdir -p ${KOS_DIR}

	# check if k0s installed
	if ! command -v k0s
	then
		# install k0s
		curl -sSLf https://get.k0s.sh | sudo sh
	fi

	k0s version

	if ! command -v k0sctl
	then
		# install k0sctl
		go install github.com/k0sproject/k0sctl@latest
	fi

	# install kosctl
	k0sctl version

	# create bash completions

	k0s completion bash > ${kos_dir}/bash_completion
	k0sctl completion >> ${kos_dir}/bash_completion

	# Install k0s as a service 
	sudo k0s install controller --single

	# Start k0s as a service
	sudo k0s start

	# Check service, logs and k0s status
	sudo k0s status
	systemctl status k0scontroller

	# Access your cluster using kubectl
	sudo k0s kubectl get nodes
}

function k0s_remove {
	sudo k0s stop
	sudo k0s reset

	echo "Reboot system to complete removal"
}
