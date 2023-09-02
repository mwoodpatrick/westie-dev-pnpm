#kubectl-helm-debian Note: You can use any Debian/Ubuntu based image you want. 
FROM archlinux:base-devel

# Options
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG USE_MOBY="true"
ARG USERNAME=admin
ARG USER_UID=1000
ARG USER_GID=$USER_UID
# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
# COPY ${GIT_ROOT}/home/scripts/arch/* /tmp
# RUN pacman -Sy && /bin/bash /tmp/library-scripts/common-arch.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
#     && /bin/bash /tmp/library-scripts/docker-arch.sh "true" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}" "${USE_MOBY}" \
#     && /bin/bash /tmp/library-scripts/kubectl-helm-arch.sh "latest" "latest" "latest" \
#     && paccache -r && rm -rf /tmp/library-scripts/

RUN echo -e '#!/usr/bin/env bash\nexec "$@"' > /usr/local/share/docker-init.sh && \
    chmod +x /usr/local/share/docker-init.sh

# Script copies localhost's ~/.kube/config file into the container and swaps out 
# localhost for host.docker.internal on bash/zsh start to keep them in sync.
# COPY copy-kube-config.sh /usr/local/share/
# RUN chown ${USERNAME}:root /usr/local/share/copy-kube-config.sh \
#     && echo "source /usr/local/share/copy-kube-config.sh" | tee -a /root/.bashrc /root/.zshrc /home/${USERNAME}/.bashrc >> /home/${USERNAME}/.zshrc

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access to 
# the Docker socket if "overrideCommand": false is set in devcontainer.json. 
# The script will also execute CMD if you need to alter startup behaviors.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Uncomment this section to install additional OS packages.
# RUN pacman -Sy <your-package-list-here>
