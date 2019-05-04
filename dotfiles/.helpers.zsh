

curl::loop() {
    local url fmt interval
    url="$1"
    [[ -n $2 ]] && interval="$2" || interval="1"
    [[ -n $3 ]] && fmt="$3" || fmt="$(date +'%F %T') :: %{http_code}\n"
    while sleep ${interval}; do
        curl -s -o /dev/null -w ${fmt} ${url} ;
    done
}
