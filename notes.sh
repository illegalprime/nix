# Set User Icon on SDDM
setfacl -m u:sddm:x /home/michael
setfacl -m u:sddm:r /home/michael/.face.icon

# Download new data from PIA
curl "https://www.privateinternetaccess.com/vpninfo/servers?version=24" \
    | head -1 \
    | sudo tee nixos/pia-config.json
