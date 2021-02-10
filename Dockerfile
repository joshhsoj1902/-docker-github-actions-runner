FROM myoung34/github-runner:2.277.1

# Kubectl
RUN apt update && \
      apt install -y curl && \
      curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl

# Helm
RUN  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
      && chmod 700 get_helm.sh \
      && ./get_helm.sh

# YQ
RUN add-apt-repository ppa:rmescandon/yq \
      && apt-get update \
      && apt-get install -y yq

ADD healthy.sh .
