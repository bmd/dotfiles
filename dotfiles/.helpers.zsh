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

# Use the 1Password CLI to restore SSH Keys from a 1password vault. Keys will
# be written to $outdir with 600 permissions. Any document tagged with $tag
# are assumed to be SSH keys, so make sure that the $tag value is only used
# for this purpose. Existing keys will be overwritten, so don't fuck it up.
#
# Usage:
#   op::keys::restore outdir vault tag
op::keys::restore() {
    local outdir vault tag documents
    outdir="$1"
    vault="$2"
    tag="$3"
    documents=$(op list documents --vault="${vault}" | jq -r '.[] | select(.overview.tags[] | contains("${tag}")).uuid,.overview.title' | xargs -L2 echo)

    while read -r line; do
        fkey=$(echo $line | cut -f1 -d ' ')
        fname=$(echo $line | cut -f2 -d ' ')
        echo "Writing $fkey to $fname"
        op get document ${fkey} > ${outdir}/${fname}
        chmod 600 ${outdir}/${fname}
    done <<< "${documents}"
}

# Backup all of the files in a folder using the 1Password CLI and tag them with
# a shared tag.
#
# Usage:
#   op::keys::backup indir vault tag
op::keys::backup() {
    local indir vault tag base
    indir="$1"
    vault="$2"
    tag="$3"

    existing_documents=$(
        op list documents --vault="${vault}" | \
        jq "[ .[] | select(.overview.tags[] | contains(\"${tag}\")) ]"
    )

    for file in $1/*(.); do
        # 1) Get the basename of the file
        base=$(basename $file);
        echo "==> Backing up ${base} to ${vault}"

        # 2) Find if there is an existing file with the same name and save its ID
        existing_uuid=$(echo ${existing_documents} | jq -r ".[] | select(.overview.title == \"${base}\").uuid")
        if [[ -n $existing_uuid ]]; then
            echo "    There is a previous version of this file with UUID \"${existing_uuid}\""
        else
            echo "    This is a new file!"
        fi
        # 3) Upload the new file and confirm that a new UID was issued
        new_uuid=$(op create document ${file} --title=${base} --vault=${vault} --tags=${tag} | jq -r .uuid)

        echo "    Successfully uploaded ${base} - the new UUID is \"${new_uuid}\""

        # 4) Delete the file by UID we saved in (2)
        if [[ -n $existing_uuid ]]; then
            op delete item ${existing_uuid} --vault="${vault}"
            echo "    Deleted old version"
        fi
    done
}
