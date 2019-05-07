if [[ $(uname) == "Darwin" ]]; then
    JETBRAINS_PLUGIN_DIR="$HOME/Library/Application Support"
    JETBRAINS_PLUGIN_API="https://plugins.jetbrains.com"
fi

# Helper function to check whether a given integer ID corresponds to an
# existing jetbrains plugin. It echoes "" when the plugin doesn't exist
# and "ok" if it does, which means that you can use something like the
# following conditional to switch on whether the plugin exists.
#
# if [[ -z jetbrains::plugin::exists 1234 ]]; then
#     echo "No plugins here" && return 1
# fi
#
# Usage:
#   jetbrains::plugin::exists <plugin-id>
jetbrains::plugin::exists() {
    plugin_id="$1"
    code=$(curl -s -o /dev/null -w "%{http_code}" ${JETBRAINS_PLUGIN_API}/api/plugins/${plugin_id}/updates)

    [[ $code == "404" ]] && echo "" || echo "ok"
}

# Install a jetbrains plugin for a specific editor by its unique ID. This isn't
# the most efficient, but there doesn't seem to be an easily-accessible map of
# these unique IDs to plugin names.
#
# Usage:
#   jetbrains::plugin::install <editor> <plugin-id>
# Example:
#   jetbrains::plugin::install PhpStorm 12345
jetbrains::plugin::install() {
    local editor plugin_id plugins_dir

    editor="$1"
    plugin_id="$2"

    if [[ -z $editor ]] || [[ -z $plugin_id ]]; then
        echo "Usage: jetbrains::plugin::install <editor> <plugin-id>"
        return 1
    fi

    # Figure out which is the most recently-installed version of our given IDE.
    plugins_dir=$(ls -1d ${JETBRAINS_PLUGIN_DIR}/${editor}* | sort | tail -n1)
    if [[ -z $plugins_dir ]]; then
        echo "No directories matching ${JETBRAINS_PLUGIN_DIR}/${editor}"
        return 1
    fi
    echo "Installing plugin in ${plugins_dir}..."

    # Now see if the plugin with that ID actually exists
    if [[ -z $(jetbrains::plugin::exists $plugin_id) ]]; then
        echo "No plugin with id ${plugin_id} found"
        return 1
    fi

    latest_version=$(curl -s ${JETBRAINS_PLUGIN_API}/api/plugins/${plugin_id}/updates | jq -r '.[0].file')
    echo "Downloading ${latest_version}..."
    curl -L -s -o "/tmp/${editor}_plugin_${plugin_id}.zip" "${JETBRAINS_PLUGIN_API}/files/${latest_version}"

    echo "Installing plugin"
    unzip -o "/tmp/${editor}_plugin_${plugin_id}.zip" -d ${plugins_dir}
    rm -f "/tmp/${editor}_plugin_${plugin_id}.zip"
}
