#!/bin/zsh
# .aws.zsh

# Look up an ACM certificate without needing to write the full
# ARN as the AWS CLI makes you do.
#
# Usage:
#   aws::acm::lookup account certificate [region] [profile]
aws::acm::lookup() {
    local account certificate region profile
    if [[ -z $1 ]] || [[ -z $2 ]]; then
        echo "Usage: aws::acm::lookup account certificate [region] [profile]"
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

# Use AWS's SessionManager to open a remote pseudo-shell on a
# random instance within an Elastic Beanstalk environment. This
# saves the cumbersome process of mapping the instance ID required
# by SessionManager to the currently live instances within the
# EB app.
#
# Usage:
#   aws::beanstalk::session::start environment [profile]
aws::beanstalk::session::start() {
    local environment profile instance
    if [[ -z "$1" ]]; then
        echo "Usage: aws::beanstalk::session::start environment [profile]"
        return
    fi

    environment="$1"
    profile=$(aws::profile::resolve $2)
    instance=$(
        aws elasticbeanstalk describe-environment-resources --profile=${profile} --environment-name=${environment} | \
        jq -r ".EnvironmentResources.Instances[].Id" | \
        sort -R | \
        head -n 1
    )

    aws ssm start-session --profile=${profile} --target ${instance}
}

# Get the total size of images in an ECR Repository. Surprisingly, the
# UI doesn't give a good way of doing this.
#
# Usage:
#   aws::ecr::repo::size repository [profile]
aws::ecr::repo::size() {
    local repository profile size
    if [[ -z "$1" ]]; then
        echo "Usage: aws::ecr::repo::size repository [profile]"
        return
    fi

    repository="$1"
    profile=$(aws::profile::resolve $2)
    size=$(
        aws ecr describe-images --profile=${profile} --repository-name ${repository} | \
        jq ".imageDetails
            | map(.imageSizeInBytes)
            | add
            | ((. // 0) / (1024 * 1024))
            | floor
        "
    )

    echo "${repository}: ${size}mb"
}

# Resolve the AWS profile to pass to the --profile flag of AWS CLI
# commands. The order of resolution is:
#   1) An explicit argument passed to this function
#   2) The value of the AWS_DEFAULT_PROFILE environment variable
#   3) "default"
#
# Usage:
#   aws::profile::resolve [profile]
aws::profile::resolve() {
    local profile

    profile="${AWS_DEFAULT_PROFILE:-default}"
    [[ -n "$1" ]] && profile="$1"

    echo "${profile}"
}
