# Base VSCode Image
FROM pulumi/pulumi-pulumi/pulumi:latest
SHELL ["/bin/bash", "-c", "-e"]

#################################################################################
# Create Users and Groups
# Create User: vscode (for default devcontainer support)

# Adding Sudo as for some reason it is not included in the pulumi/pulumi-base image


# Adduser:
# - user:   vscode
# - group:  vscode
# - uid:    1000
# - gid:    1000
RUN echo \
    && export USER_ID="1000" \
    && export USER_NAME="vscode" \
    && export USER_SHELL="bash" \
    && export USER_GROUPS="${USER_NAME},sudo" \
    && export USER_GROUP_NAME="${USER_NAME}" \
    && export USER_GROUP_ID="${USER_ID}" \
    && echo "INFO[${USER_NAME}]  User:" \
    && echo "INFO[${USER_NAME}]    User Name:   ${USER_NAME}" \
    && echo "INFO[${USER_NAME}]    User Group:  ${USER_GROUP_NAME}" \
    && echo "INFO[${USER_NAME}]    Aux Groups:  ${USER_GROUPS}" \
    && echo "INFO[${USER_NAME}]    Group ID:    ${USER_GROUP_ID}" \
    && echo "INFO[${USER_NAME}]    User ID:     ${USER_ID}" \
    && echo "INFO[${USER_NAME}]    SHELL:       $(which ${USER_SHELL})" \
    && groupadd --gid ${USER_ID} ${USER_GROUP_NAME} \
    && useradd --create-home --uid ${USER_ID} --gid ${USER_ID} --shell $(which ${USER_SHELL}) --groups ${USER_GROUPS} ${USER_NAME} \
    #
    # Adding Sudo Support
    && apt-get update \
    && apt-get install -y sudo \
    && echo "${USER_NAME} ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME \
    && echo

RUN sudo chown vscode:vscode -R /home/vscode

#################################################################################
# Base package and user configuration
#################################################################################

# Common Dockerfile Container Build Functions
ENV apt_update="sudo apt-get update"
ENV apt_install="TERM=linux DEBIAN_FRONTEND=noninteractive sudo apt-get install -q --yes --purge --assume-yes --auto-remove --allow-downgrades -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'"
ENV apt_clean="sudo apt-get clean && sudo apt-get autoremove -y && sudo apt-get purge -y --auto-remove"
ENV INSTALL="install -m 755 -o root -g root"
ENV curl="/usr/bin/curl --silent --show-error --tlsv1.2 --location"
ENV curl_github="/usr/bin/curl --silent --show-error --tlsv1.2 --request GET --url"
ENV dir_clean="\
    sudo rm -rf \
    /var/lib/{apt,cache,log} \
    /usr/share/{doc,man,locale} \
    /var/cache/apt \
    /home/*/.cache \
    /root/.cache \
    /var/tmp/* \
    /tmp/* \
    "

# Apt Packages
ARG APT_PKGS="\
    gh \
    vim \
    jq \
    tree \
    python3 \
    python3-pip \
    "

# Apt Packages
RUN echo \
    && export TEST="gh version" \
    && ${apt_update} \
    && bash -c "${apt_install} --no-install-recommends -o Dpkg::Options::='--force-confold' ${APT_PKGS}" \
    && bash -c "${apt_clean}" \
    && ${dir_clean} \
    && ${TEST} \
    && echo

#################################################################################
# install Kubernetes tools
#################################################################################
# Install Kubectl
# - https://kubernetes.io
# - github.com/kubernetes/kubernetes
RUN echo \
    && export NAME=kubectl \
    && export TEST="${NAME} version --client" \
    && export VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)" \
    && export ARCH=$(uname -m | awk '{ if ($1 == "x86_64") print "amd64"; else if ($1 == "aarch64" || $1 == "arm64") print "arm64"; else print "unknown" }') \
    && export PKG="${NAME}" \
    && export URL="https://dl.k8s.io/release/${VERSION}/bin/linux/${ARCH}/${PKG}" \
    && echo "---------------------------------------------------------"\
    && echo "INFO[${NAME}] Installed:" \
    && echo "INFO[${NAME}]   Command:        ${NAME}" \
    && echo "INFO[${NAME}]   Package:        ${PKG}" \
    && echo "INFO[${NAME}]   Latest Release: ${VERSION}" \
    && echo "INFO[${NAME}]   Architecture:   ${ARCH}" \
    && echo "INFO[${NAME}]   Source:         ${URL}" \
    && echo "---------------------------------------------------------"\
    && ${curl} ${URL} --output /tmp/${NAME} \
    && ${INSTALL} /tmp/kubectl /usr/local/bin/${NAME} \
    && ${dir_clean} \
    && ${TEST} \
    && echo


##################################################################################
# Starting vscode side installs. [TODO] Move these if possible.
##################################################################################
#
# Set User & Workdir default to $HOME
USER vscode
WORKDIR /home/vscode