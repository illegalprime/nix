#!/usr/env/bash
set -euo pipefail

# Download new data from PIA
curl "https://www.privateinternetaccess.com/vpninfo/servers?version=24" \
    | head -1 \
    | sudo tee pia-config.json
