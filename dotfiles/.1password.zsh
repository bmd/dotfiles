#!/bin/zsh
# .1password.zsh

# Use the 1Password CLI to restore SSH Keys from a 1password vault. Keys will
# be written to $outdir with 600 permissions. Any document tagged with $tag
# are assumed to be SSH keys, so make sure that the $tag value is only used
# for this purpose. Existing keys will be overwritten, so don't fuck it up.
#
# Usage:
#   op::keys::restore outdir vault tag
op::keys::restore() {
    local outdir vault tag documents uuid filename
    outdir="$1"
    vault="$2"
    tag="$3"
    documents=$(
        op list documents --vault="${vault}" | \
        jq -r ".[]
            | select(.trashed == \"N\")
            | select(
                .overview.tags[] | contains(\"${tag}\")
              )
            | [.uuid,.overview.title]
            | @tsv
        "
    )

    while IFS=$'\t' read -A line; do
        uuid="${line[1]}"
        filename="${line[2]}"
        echo "Restoring ${outdir}/${filename}"
        op get document --vault="${vault}" ${uuid} > ${outdir}/${filename}
        chmod 600 ${outdir}/${filename}
    done <<< ${documents}
}

# Backup all of the files in a folder using the 1Password CLI and tag them with
# a shared tag.
#
# The op CLI tool doesn't support any update or replace operations against an existing
# file, so in order to simulate "replacing" a previous version of the backed-up file, a
# new version will be created with the same name and  then the old version is deleted.
# This operation is not atomic, but the implication of a failure is that two backed-up
# versions with different timestamps will exist, in which case they can be manually
# reconciled.
#
# Files that are deleted from the source directory will not be deleted from 1pw,
# ensuring that a backup is available. If you want to delete these files from 1pw,
# you will need to do it manually
#
# Usage:
#   op::keys::backup indir vault tag
op::keys::backup() {
    local indir vault tag base existing_documents existing_uuid new_uuid
    indir="$1"
    vault="$2"
    tag="$3"

    existing_documents=$(
        op list documents --vault="${vault}" | \
        jq "[
            .[]
            | select(.overview.tags[]
            | contains(\"${tag}\"))
        ]"
    )

    for file in $1/*(.); do
        base=$(basename ${file});
        echo "==> Backing up ${base} to ${vault}"

        existing_uuid=$(
            echo ${existing_documents} | \
            jq -r ".[]
                | select(.overview.title == \"${base}\").uuid
            "
        )

        if [[ -n ${existing_uuid} ]]; then
            echo "    There is a previous version of this file with UUID \"${existing_uuid}\""
        else
            echo "    This is a new file!"
        fi

        new_uuid=$(
            op create document ${file} --title=${base} --vault=${vault} --tags=${tag} | \
            jq -r .uuid
        )
        echo "    Successfully uploaded ${base} - the new UUID is \"${new_uuid}\""

        if [[ -n ${existing_uuid} ]]; then
            op delete item ${existing_uuid} --vault="${vault}"
            echo "    Deleted old version"
        fi
    done
}
