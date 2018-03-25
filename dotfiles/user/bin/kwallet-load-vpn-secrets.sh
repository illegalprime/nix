#!/usr/bin/env bash
set -euo pipefail

echo 'All pia configs should be in /etc/NetworkManager/system-connections/pia-*'
echo -n 'password: '
read -s password

sudo find /etc/NetworkManager/system-connections \
     -type f -regextype egrep -iregex '(.*pia-.*)|(.*PIA - .*)' \
    | while read PIA; do
    # UUID
    echo "Found ${PIA}."
    uuid=$(sudo cat "$PIA" | grep uuid | cut -d= -f2)
    echo "{\"VpnSecrets\":\"password%SEP%${password}\"}" \
        | kwallet-query kdewallet -f 'Network Management' -w "{${uuid}};vpn"
done
