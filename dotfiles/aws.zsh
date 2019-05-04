#!/bin/zsh
# aws.zsh - AWS helper functions for things I use frequently

# Look up an ACM certificate without needing to write the full
# ARN as the AWS CLI makes you do.
#
# Usage:
#   aws::acm::lookup account certificate [region] [profile]
aws::acm::lookup() {
    local account certificate region profile

    if [[ -n $1 ]] || [[ -n $2 ]]; then
        echo "USAGE: aws::acm::lookup account certificate [region] [profile]"
        return
    fi

    account="$1"
    certificate="$2"
    [[ -n $3 ]] && region="$3" || region="us-east-1"
    profile=$(aws::profile::resolve $4)

    aws acm describe-certificate \
      --profile=${profile} \
      --certificate-arn arn:aws:acm:us-east-1:${account}:certificate/${certificate}
}

aws::beanstalk::session::start() {
    local environment profile instance

    environment="$1"
    [[ -n $2 ]] && profile="$2" || profile="default"
    local instance=$(aws elasticbeanstalk describe-environment-resources --profile=${profile} --environment-name=${environment} | jq -r ".EnvironmentResources.Instances[].Id" | sort -R | head -n 1)

    aws ssm start-session --profile=${profile} --target ${instance}
}

aws::ecr::repo::size() {
    local repository profile size

    if [[ -n $1 ]]; then
        echo "Usage: $0 repository [profile]"
        return
    fi

    repository="$1"
    profile=$(aws::profile::resolve $2)

    size=$(aws ecr describe-images --repository-name ${repository} --profile ${profile} | jq '.imageDetails | map(.imageSizeInBytes) | add | ((. // 0) / (1024 * 1024)) | floor')
    echo "${repository}: ${size}mb"
}

aws::profile::resolve() {
    local profile
    profile="${AWS_DEFAULT_PROFILE:-default}"
    [[ -n $1 ]] && profile="$1"

    return profile
}


