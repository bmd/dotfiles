#!/bin/zsh
# aliases.zsh

# Simple command aliases
alias bt='ssh bastion-tools'
alias mkdir="mkdir -p"

# Include my shell libraries
source aws.zsh
source helpers.zsh

mcd() { mkdir -p "$1" && cd "$1"; }
j64() { echo $@ | base64 --decode | jq . ; }
yq() { yaml2json | jq $@ ; }
clone() { cd ~/git && git clone git@github.com:$1 && cd $(basename "$1"); }
check_url() { curl::loop $1; }

op::keys::restore() {
    local outdir tag documents
    outdir="$1"
    [[ -n $2 ]] && tag="$2" || tag="ssh-keys"
}

restore_ssh_keys() {
  DOCUMENTS=$(op list documents --vault="Blue State Digital" | jq -r '.[] | select(.overview.tags[] | contains("ssh-keys")).uuid,.overview.title' | xargs -L2 echo)
  OUTDIR="$1"
  while read -r line; do
    fileKey=$(echo $line | cut -f1 -d ' ')
    fileName=$(echo $line | cut -f2 -d ' ')
    echo "Writing $fileKey to $fileName"
    op get document ${fileKey} > "$OUTDIR/${fileName}"
  done <<< "$DOCUMENTS"
}

err() { echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2; }
tesseract_cert() { aws::acm::lookup 093597997342 $1 "us-east-1" "bsd-tesseract" | jq . ; }
tesseract_session() { beanstalk::session ; }
