FROM jenkins/jnlp-slave

ENV HELM_VERSION="v3.5.3"
ENV NODE_VERSION="16.x"

USER root

# Setup the repository
RUN apt-get update
RUN apt-get install -y wget build-essential gcc make cmake curl gnupg
RUN apt-get install -y ca-certificates
RUN apt-get install -y lsb-release
RUN apt-get install -y apt-transport-https
RUN apt-get install -y software-properties-common

# Install NodeJS
RUN curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}" | bash - && apt-get install -y nodejs
RUN npm install -g yarn --force
RUN npm --version
RUN yarn --version

# Install Helm
RUN wget "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" \
    && tar -xvf "helm-${HELM_VERSION}-linux-amd64.tar.gz" \
    && mv linux-amd64/helm /usr/local/bin \
    && rm "helm-${HELM_VERSION}-linux-amd64.tar.gz" \
    && rm -rf linux-amd64
RUN helm version

# Install docker
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get install -y docker-ce
RUN apt-get install -y docker-ce-cli
RUN apt-get install -y containerd.io
RUN apt-get install -y docker-compose-plugin
RUN docker --version

USER jenkins
