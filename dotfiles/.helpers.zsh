#!/bin/zsh
# .helpers.zsh

# Curl a URL in a loop and print a formatted output string from the result of
# each request. Valid arguments to $format are a valid `--write-out` string
# for the curl command. See here for supported parameters:
#   http://www.mit.edu/afs.new/sipb/user/ssen/src/curl-7.11.1/docs/curl.html
#
# Usage:
#   curl::loop url [interval] [format]
curl::loop() {
    local url fmt interval
    url="$1"
    [[ -n $2 ]] && interval="$2" || interval="1"
    [[ -n $3 ]] && fmt="$3\n"    || fmt="%{url_effective} - %{http_code} (%{time_total}s)\n"
    while sleep ${interval}; do
        curl -L -s -o /dev/null -w "[$(date +'%F %T')] ${fmt}" ${url} ;
    done
}
