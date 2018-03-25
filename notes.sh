# Set User Icon on SDDM
setfacl -m u:sddm:x ~
setfacl -m u:sddm:r ~/.face.icon

# Add PIA password of each config to kwallet
./dotfiles/user/bin/kwallet-load-vpn-secrets.sh
