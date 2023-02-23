#!/bin/zsh
# .k8s.zsh

# Kubectl completion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
export PATH="/opt/homebrew/opt/elasticsearch@6/bin:$PATH"

alias k='kubectl'

helmvm() {
    local version=$1
    ln -sf /usr/local/bin/tiller${version} /usr/local/bin/tiller
    ln -sf /usr/local/bin/helm${version} /usr/local/bin/helm
}

kc() {
    kubectl config use-context $1
}

tail_tiller() {
    kubectl --context $1 logs -f --tail=200 -n kube-system deployment/tiller-deploy
}
