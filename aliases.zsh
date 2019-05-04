dsh () { docker exec -it $1 /bin/sh; }

alias bt='ssh bastion-tools'
alias mkdir="mkdir -p"
alias path='echo $PATH | tr -s ":" "\n" | sort | uniq'

# Make directory and change into it.

mcd() { mkdir -p "$1" && cd "$1"; }

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

clone() {
  cd ~/git && git clone git@github.com:$1 && cd $(basename "$1")
}

infcurl() {
  while sleep 1; do
    curl -s -o /dev/null -w "$(date +'%F %T') :: %{http_code}\n" $1 ;
  done
}

j64() {
  echo $@ | base64 --decode | jq .
}

yq() {
  yaml2json | jq $@
}

# From Google's shell guide
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# ---------------------------------------------------------
# AWS Helper Functions
# ---------------------------------------------------------

# Gain pseudo-shell access to an instance within a running Elastic Beanstalk
# cluster using AWS's Session Manager. In order for this command to work,
# your IAM user must be able to access Session Manager, as well as the EB
# environment you specify.
#
# Usage:
#   beanstalk-session ENVIRONMENT
beanstalk-session() {
    local environment profile instance
    if [[ -n $1 ]]; then
        echo "Usage: $0 ENVIRONMENT [PROFILE]"
        return
    fi

    environment="$1"
    [[ -n $2 ]] && profile="$2" || profile="default"
    local instance=$(aws elasticbeanstalk describe-environment-resources --profile=${profile} --environment-name=${environment} | jq -r ".EnvironmentResources.Instances[].Id" | sort -R | head -n 1)

    aws ssm start-session --target $instance
}

# Determine the total size (in Mb) of
#
reposize() {
    local repo size
    if [[ -n $1 ]]; then
        echo "Usage: $0 REPOSITORY [PROFILE]"
        return
    fi

    size=$(aws ecr describe-images --repository-name $1 | jq '.imageDetails | map(.imageSizeInBytes) | add | ((. // 0) / (1024 * 1024)) | floor')
    echo "$1 ${size} mb"
}

cert() {
    aws acm describe-certificate \
      --profile=bsd-tesseract \
      --certificate-arn arn:aws:acm:us-east-1:093597997342:certificate/$1
}
