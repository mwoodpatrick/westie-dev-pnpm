FROM alpine:latest

ARG GIT_TEA_VERSION=0.6.0
ARG KUSTOMIZE_VERSION=v3.9.1
ARG PODMAN_REMOTE_VERSION=v2.2.1

## Packages and upstream Kubernetes tools:
RUN cd /usr/local/bin && \
 apk add --no-cache bash curl openssh git bash-completion jq docker-cli && \
 echo "## Arkade installer" && \
   curl -sLS https://dl.get-arkade.dev | sh && \
   arkade get kubectl && \
   arkade get kubeseal && \
   arkade get hugo && \
   arkade get k3sup && \
   arkade get faas-cli && \
   arkade get helm && \
   arkade get k9s && \
   mv /root/.arkade/bin/* /usr/local/bin && \
 echo "### Kustomize (direct URL because arkade is broken see #299): " && \
   curl -LO https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
   tar xfvz kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
   rm kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz && \
 echo "### Flux: " && \
   curl -sL https://toolkit.fluxcd.io/install.sh | bash && \
 echo "### cdk8s / pyenv" && \
   apk add libffi-dev openssl-dev bzip2-dev zlib-dev readline-dev \
      sqlite-dev build-base python3 py3-pip yarn npm && \
   pip install --user pipenv && \
   curl https://pyenv.run | bash && \
   yarn global add cdk8s-cli && \
 echo "### Podman remote" && \
   curl -LO https://github.com/containers/podman/releases/download/${PODMAN_REMOTE_VERSION}/podman-remote-static.tar.gz && \
   tar xfvz podman-remote-static.tar.gz && \
   rm podman-remote-static.tar.gz && \
   mv podman-remote-static podman && \
 echo "## yq" && \
   pip install yq && \
 echo "## git-tea" && \
   curl -LO \
     https://dl.gitea.io/tea/${GIT_TEA_VERSION}/tea-${GIT_TEA_VERSION}-linux-amd64 && \
   mv tea-${GIT_TEA_VERSION}-linux-amd64 tea && \
   chmod 0755 tea
   
WORKDIR /root

## root account setup:
## Note that the files in the /root volume will override these image defaults:
RUN echo 'export PATH=${HOME}/.arkade/bin:${HOME}/.local/bin:${PATH}' >> .bashrc && \
    echo 'source /usr/share/bash-completion/bash_completion' >> .bashrc && \
    echo 'source <(kubectl completion bash)' >> .bashrc && \
    echo 'source <(flux completion bash)' >> .bashrc && \
    echo 'export PS1="[\u@kube-toolbox \W]\$ "' >> .bashrc && \
    echo 'set enable-bracketed-paste on' > .inputrc

CMD /bin/bash
