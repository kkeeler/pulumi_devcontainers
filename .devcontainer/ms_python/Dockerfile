FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

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
    vim \
    jq \
    tree \
    "

# Apt Packages
RUN echo \
    && ${apt_update} \
    && bash -c "${apt_install} --no-install-recommends -o Dpkg::Options::='--force-confold' ${APT_PKGS}" \
    && bash -c "${apt_clean}" \
    && ${dir_clean} \
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


#################################################################################
# pulumi packages
#################################################################################

# Install pulumi
# Install Pulumi CLI Utility
RUN echo \
    && export NAME=pulumi \
    && export TEST="pulumi version" \
    && export REPOSITORY="pulumi/pulumi" \
    && export VERSION="$(${curl} https://api.github.com/repos/${REPOSITORY}/releases/latest | jq --raw-output .tag_name)" \
    && export ARCH=$(uname -m | awk '{ if ($1 == "x86_64") print "x64"; else if ($1 == "aarch64" || $1 == "arm64") print "arm64"; else print "unknown" }') \
    && export PKG="${NAME}-${VERSION}-linux-${ARCH}.tar.gz" \
    && export URL="https://github.com/${REPOSITORY}/releases/download/${VERSION}/${PKG}" \
    && echo "---------------------------------------------------------"\
    && echo "INFO[${NAME}] Installed:" \
    && echo "INFO[${NAME}]   Command:        ${NAME}" \
    && echo "INFO[${NAME}]   Package:        ${PKG}" \
    && echo "INFO[${NAME}]   Latest Release: ${VERSION}" \
    && echo "INFO[${NAME}]   Architecture:   ${ARCH}" \
    && echo "INFO[${NAME}]   Source:         ${URL}" \
    && echo "---------------------------------------------------------"\
    && ${curl} ${URL} | tar xzvf - --directory /tmp \
    && sudo chmod 755 /tmp/pulumi/* \
    && sudo chown root:root /tmp/pulumi/* \
    && sudo mv /tmp/pulumi/* /usr/local/bin/ \
    && ${dir_clean} \
    && ${TEST} \
    && echo

# Install pulumi esc
RUN echo \
    && export NAME="esc" \
    && export TEST="esc version" \
    && export REPOSITORY="pulumi/esc" \
    && export VERSION="$(${curl} https://api.github.com/repos/${REPOSITORY}/releases/latest | jq --raw-output .tag_name)" \
    && export ARCH=$(uname -m | awk '{ if ($1 == "x86_64") print "x64"; else if ($1 == "aarch64" || $1 == "arm64") print "arm64"; else print "unknown" }') \
    && export PKG="${NAME}-${VERSION}-linux-${ARCH}.tar.gz" \
    && export URL="https://github.com/${REPOSITORY}/releases/download/${VERSION}/${PKG}" \
    && echo "---------------------------------------------------------"\
    && echo "INFO[${NAME}] Installed:" \
    && echo "INFO[${NAME}]   Command:        ${NAME}" \
    && echo "INFO[${NAME}]   Package:        ${PKG}" \
    && echo "INFO[${NAME}]   Latest Release: ${VERSION}" \
    && echo "INFO[${NAME}]   Architecture:   ${ARCH}" \
    && echo "INFO[${NAME}]   Source:         ${URL}" \
    && echo "---------------------------------------------------------"\
    && ${curl} ${URL} | tar xzvf - --directory /tmp \
    && sudo ${INSTALL} /tmp/${NAME}/${NAME} /usr/local/bin/${NAME} \
    && ${dir_clean} \
    && ${TEST} \
    && echo

##################################################################################
# Install StarShip for prompt awesomeness
##################################################################################
RUN echo \
    && export NAME=starship \
    && export TEST="${NAME} --version" \
    && export URL="https://starship.rs/install.sh" \
    && ${curl} ${URL} --output /tmp/${NAME} \
    && chmod +x /tmp/${NAME} \
    && bash -c "/tmp/${NAME} --verbose --yes" \
    && ${dir_clean} \
    && ${TEST} \
    && echo


# Set User & Workdir default to $HOME
USER vscode
WORKDIR /home/vscode

RUN curl -fsSL https://get.pulumi.com | sh
