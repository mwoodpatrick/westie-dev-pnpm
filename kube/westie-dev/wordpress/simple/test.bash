#!/usr/bin/env bash
# Simple WordPress example
# https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/
export MYSQL_DATABASE=wp-test
export MYSQL_USER=root
export MYSQL_PASSWORD=mysql_password
export WP_ADMIN_USER=wp_admin_user23
export WP_ADMIN_PASSWORD=wordpress
export TEST_NS="wordpress-test"
export TEST_CONTEXT=westie-wp-test

function htest { helm --kube-context $TEST_CONTEXT $@; }
function ktest { kubectl --context $TEST_CONTEXT $@; }
function mtest { minikube -p $TEST_CONTEXT $@; }

test_pids=()

function list-test-pids {
    echo "${test_pids[*]}"
}

function delete-test-pids {
    for i in "${test_pids[@]}"
    do
        kill -TERM "$i"
        
    done
    test_pids=()
}

function cleanup {
    # kubectl -n $TEST_NS delete --ignore-not-found=true -k .
    minikube delete -p $TEST_CONTEXT
    delete-test-pids
}

# ensure openebs is running
function verify-openebs {
    ktest get pods -n openebs
    # if pod is stuck in creating do a kt describe pod <pod>
    ktest get storageclasses
}

function wp-get-pods {
    ktest -n $TEST_NS get pods
}

function wp-ssh-pod {
    local pod=$1
    shift
    echo "execing into pod $pod"
    echo ktest -n $TEST_NS exec -it $pod -- bash
    ktest exec -n $TEST_NS -it $pod -- bash
}

function create-or-update {
    minikube start --memory 4000 --cpus 2 --kubernetes-version latest -p $TEST_CONTEXT
    # OpenEBS needs /run/udev in order to run see [Need to have support for udev in k3os](https://github.com/rancher/k3os/issues/151)
    # [Running minikube in docker-in-docker](https://discuss.kubernetes.io/t/running-minikube-in-docker-in-docker/22366/7)
    #
    mtest mount /run/udev:/run/udev&
    test_pids+=($!)
    htest repo add openebs https://openebs.github.io/charts
    htest repo update
    htest install openebs --namespace openebs openebs/openebs --create-namespace
    mtest mount /mnt/wsl/projects:/projects&
    test_pids+=($!)
    ktest create namespace $TEST_NS
    ktest -n $TEST_NS apply -k ./
    ktest -n $TEST_NS wait --timeout=5m deployment.apps/wordpress-mysql --for=condition=Available
    ktest -n $TEST_NS wait --timeout=5m deployment.apps/wordpress --for=condition=Available
    mtest service wordpress -n $TEST_NS --url&
    test_pids+=($!)
}

function check {
    kubectl get secrets
    kubectl get pvc
    kubectl get pods
    kubectl get svc
}

echo "Welcome to WordPress test, you can excute: cleanup, create, check commands"
