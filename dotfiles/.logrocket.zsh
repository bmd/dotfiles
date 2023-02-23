#!/bin/zsh
# .logrocket.zsh

delete_sessions_from_file() {
    local sessions_file=$1
    jq -R -s -c 'split("\n")[:-1] | { "token": "MINI-ARMAGEDDON", "prefixes": . }' $sessions_file \
    | curl -X POST http://localhost:5005/delete-specific-sessions -H 'Content-Type: application/json' -d @-
}
