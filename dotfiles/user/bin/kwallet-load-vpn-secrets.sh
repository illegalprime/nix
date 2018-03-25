#!/usr/bin/env bash
set -euo pipefail

function header() {
    cat <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<wallet name="kdewallet">
    <folder name="Network Management">
EOF
}

function footer() {
    cat <<EOF
    </folder>
</wallet>
EOF
}

echo 'All pia configs should be in /etc/NetworkManager/system-connections/pia-*'
echo -n 'password: '
read -s password
echo

function make-config() {
    sudo find /etc/NetworkManager/system-connections \
         -type f -regextype egrep -iregex '(.*pia-.*)|(.*PIA - .*)' \
        | while read PIA; do
        # UUID
        echo "Found ${PIA}." >&2
        uuid=$(sudo cat "$PIA" | grep uuid | cut -d= -f2)
        cat <<EOF
        <map name="{${uuid}};vpn">
            <mapentry name="VpnSecrets">password%SEP%${password}</mapentry>
        </map>
EOF
    done
}

sudo true
XML_DATA=$(
    header
    make-config
    footer
)

echo "$XML_DATA" > secrets.xml

