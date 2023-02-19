# [Deploy Kubernetes Cluster on Linux With k0s](https://computingforgeeks.com/deploy-kubernetes-cluster-on-linux-with-k0s/)
# [k0s | Kubernetes distribution for bare-metal, on-prem, edge, IoT (k0sproject.io)](https://k0sproject.io/)
# [Documentation (k0sproject.io)](https://docs.k0sproject.io/v1.26.1+k0s.0/)
# [k0sproject/k0s: k0s - The Zero Friction Kubernetes (github.com)](https://github.com/k0sproject/k0s)
# [k0s vs k3s - Search (bing.com)](https://www.bing.com/search?q=k0s+vs+k3s&form=ANNTH1&refig=4d041ab62acb4b2584a82f8beea6f252&sp=1&qs=LT&pq=k0s+&sc=10-4&cvid=4d041ab62acb4b2584a82f8beea6f252)
#
# Data Directory for k0s (default: /var/lib/k0s)
#   bin  containerd  db  images  kubelet  kubelet-config.yaml  kubelet.conf  manifests  pki  worker-profile.yaml
# 

echo "BASH_SOURCE=${BASH_SOURCE[0]}"
export K0S_HOME=`dirname $(realpath ${BASH_SOURCE[0]})`
echo "K0S_HOME=${K0S_HOME}"

function k0s_configure {
    export K0S_DIR=${HOME}/.k0s

    unset KUBECONFIG
    
    alias kubectl='f(){ sudo k0s kubectl "$@";  unset -f f; }; f'

	mkdir -p ${K0S_DIR}

	# check if k0s installed
	if ! command -v k0s
	then
		# install k0s
		curl -sSLf https://get.k0s.sh | sudo sh
	fi

    if ! systemctl --all --type service | grep -q "k0s";then
        echo "installing k0s service."

	    # Install k0s as a service 
        # /etc/systemd/system/k0scontroller.service

	    sudo k0s install controller --single

	    # Start k0s as a service
	    sudo k0s start
    fi

	if ! command -v k0sctl
	then
		echo install k0sctl
		go install github.com/k0sproject/k0sctl@latest
	fi

	# create bash completions

    if [ -f "${K0S_DIR}/bash_completion" ]; then
	    k0s completion bash > ${K0S_DIR}/bash_completion
	    k0sctl completion >> ${K0S_DIR}/bash_completion
    fi

    . "$K0S_DIR/bash_completion" # This loads k0s bash_completion
}

function k0s_dependency_issues {
    # check for any dependency issues
    k0s sysinfo|grep -v pass
}

# Check service, logs and k0s status
function k0s_status {
	echo "k0s version: $(k0s version)"
	echo "k0sctl $(k0sctl version)"

    sudo k0s status
    sudo systemctl status k0scontroller

	# Access your cluster using kubectl
	sudo k0s kubectl get nodes

    k0s_dependency_issues
}

function k0s_update_configuration {
    mkdir -p /etc/k0s

    sudo cp ${K0S_HOME}/k0s.yaml /etc/k0s
    # runtime values in /run/k0s/k0s.yaml

    echo "updating k0s config in /etc/k0s from ${K0S_HOME}/k0s.yaml"

    sudo k0s stop
    sudo k0s start
    sudo k0s status
}

function k0s_remove {
    if [ $(ps | grep -v grep | grep k0s | wc -l) -gt 0 ]
    then
        echo "k3s is running!!!"
	    sudo k0s stop
    else
        echo "k3s is not running!!!"
    fi

	sudo k0s reset

	echo "Reboot system to complete removal"
}

k0s_configure
