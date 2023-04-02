# westie-dev-pnpm
Monorepo with Nx and pnpm Workspaces

# KIND

[kind (k8s.io)](https://kind.sigs.k8s.io/)

> [kubernetes-sigs/kind: Kubernetes IN Docker - local clusters for
> testing Kubernetes
> (github.com)](https://github.com/kubernetes-sigs/kind)
>
>  
>
> kind \--version
>
> kind version 0.17.0
>
>  
>
> See:
>
>  
>
> [Releases · kubernetes-sigs/kind
> (github.com)](https://github.com/kubernetes-sigs/kind/releases)
>
>  
>
> [Releases \| Kubernetes](https://kubernetes.io/releases/)
>
>  
>
> [API Overview \|
> Kubernetes](https://kubernetes.io/docs/reference/using-api/)
>
>  

cd /home/mwoodpatrick/projects/git/westie-dev-pnpm

>  

export KUBECONFIG=\`pwd\`/kube/admin.conf

 

kind create cluster \--config kube/cluster-config/master\_node.yml

 

kind get kubeconfig \--name app-1-cluster-master-only

 

kind create cluster \--config kube/cluster-config/three\_node.yml

 

kind get kubeconfig \--name app-1-cluster-master-slave-slave

 

kubectl config get-contexts

 

kubectl cluster-info \--context kind-app-1-cluster-master-slave-slave

 

kubectl cluster-info dump \--context
kind-app-1-cluster-master-slave-slave

 

docker exec -it app-1-cluster-master-slave-slave-worker bash

 

sudo cp \$KUBECONFIG /etc/kubernetes

>  
>
>  

 

[kubeadm config \|
Kubernetes](https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-config/)

 

[Top Kubernetes and OpenShift resources of 2022 \| Red Hat
Developer](https://developers.redhat.com/articles/2022/12/06/top-kubernetes-and-openshift-resources-2022#containers)

 

[kubernetes github codespaces - Search
(bing.com)](https://www.bing.com/search?q=kubernetes+github+codespaces&form=ANNTH1&refig=70dcbf97873549e7908c66bd474254d6)

 

[kind -- Using WSL2
(k8s.io)](https://kind.sigs.k8s.io/docs/user/using-wsl2/)

 

General recommendation is to use docker rather than podman with kind due
to stablility issues see [Podman on WSL2 fails kind create cluster as
root and not as root · Issue \#2452 · kubernetes-sigs/kind
(github.com)](https://github.com/kubernetes-sigs/kind/issues/2452) and
[Slack: how reliable kind is on top of Podman on Fedora?
-](https://kubernetes.slack.com/archives/CEKK1KTN2/p1670344092562079)

 

<https://www.bing.com/search?q=vscode+kind&cc=US&setlang=en&PC=SWG01&form=SPIT01&scope=web>

 

[Configuring a KinD Cluster with NGINX Ingress Using Terraform and
Helm](https://www.youtube.com/watch?v=Nm2c9xvGMpU)