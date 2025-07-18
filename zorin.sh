#!/usr/bin/env bash

set -o pipefail

# Make sure the temp directory gets removed on script exit.
trap 'exit 1' HUP INT PIPE QUIT TERM
trap '
if [ -n "$TEMPD" ]; then
    case "$TEMPD" in
        /tmp/*)
            if command rm -rf "$TEMPD"; then
                echo "Cleaned up temporary directory \"$TEMPD\" successfully!"
            fi
            ;;
        *)
            echo "Warning: TEMPD=\"$TEMPD\" is outside /tmp/, refusing to delete for safety."
            ;;
    esac
fi
if [ -e "$TEMPD" ]; then
    echo "Temp Directory \"$TEMPD\" was not deleted correctly; you need to manually remove it!"
fi
' EXIT

echo "███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ██║   ██║███████╗    ██████╔╝██████╔╝██║   ██║"
echo " ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║    ██║   ██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║    ╚██████╔╝███████║    ██║     ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v9.0.4.2| |Overhauled & Maintained By NamelessNanasi/NanashiTheNameless| |original by kauancvlcnt|"
echo ""
echo "(Please note this version ONLY works on Zorin 17 and 16)"
echo ""
echo "(to use this script on Zorin 16 add the -6 flag or -7 for zorin 17)"
echo "(add -X for a lot extra content)"
echo ""
echo "THIS CODE AND THE ACCOMPANYING DOCUMENTATION WERE SIGNIFICANTLY OVERHAULED BY NamelessNanashi/NanashiTheNameless."
echo "https://github.com/NanashiTheNameless/Zorin-OS-Pro IS THE OFFICIAL SOURCE FOR THIS TOOL."
echo "IF YOU GOT THIS CODE ELSEWHERE KNOW THAT THE CODE SHOULD NOT BE FULLY TRUSTED."
echo ""

sleep 8

function fail() {
        echo ""
        echo "You are not running this script correctly, read the GitHub https://github.com/NanashiTheNameless/Zorin-OS-Pro/ for more info"
        echo ""
        exit 1
}

# Parse command line arguments for flag
apt_no_confirm=""
extra="false"
while getopts "67XU" opt; do
  case $opt in
    6)
        version="16"
    ;;
    7)
        version="17"
    ;;
    X)
        extra="true"
    ;;
    U)
        apt_no_confirm="-y"
    ;;
    esac
done
if [ -z ${version+x} ] ; then fail; fi

echo ""
echo "Preparing to install dependencies..."
echo ""

# Prompt user
echo "Please Enter your sudo password!"

# Sudo -v so it always propts here
sudo -v

# Install ca-certificates and curl
sudo apt-get update
sudo apt-get install ${apt_no_confirm} ca-certificates curl

sleep 2

echo ""
echo "Updating the default sources.list for Zorin's custom resources..."
echo ""

function AddSources16() {
sudo \rm -f /etc/apt/sources.list.d/zorin.list
sudo \touch /etc/apt/sources.list.d/zorin.list
sudo \tee /etc/apt/sources.list.d/zorin.list > /dev/null << 'EOF'
deb https://packages.zorinos.com/stable focal main
deb-src https://packages.zorinos.com/stable focal main

deb https://packages.zorinos.com/patches focal main
deb-src https://packages.zorinos.com/patches focal main

deb https://packages.zorinos.com/apps focal main
deb-src https://packages.zorinos.com/apps focal main

deb https://packages.zorinos.com/drivers focal main restricted
deb-src https://packages.zorinos.com/drivers focal main restricted

deb https://packages.zorinos.com/premium focal main
deb-src https://packages.zorinos.com/premium focal main

EOF
}

function AddSources17() {
sudo \rm -f /etc/apt/sources.list.d/zorin.list
sudo \touch /etc/apt/sources.list.d/zorin.list
sudo \tee /etc/apt/sources.list.d/zorin.list > /dev/null << 'EOF'
deb https://packages.zorinos.com/stable jammy main
deb-src https://packages.zorinos.com/stable jammy main

deb https://packages.zorinos.com/patches jammy main
deb-src https://packages.zorinos.com/patches jammy main

deb https://packages.zorinos.com/apps jammy main
deb-src https://packages.zorinos.com/apps jammy main

deb https://packages.zorinos.com/drivers jammy main restricted
deb-src https://packages.zorinos.com/drivers jammy main restricted

deb https://packages.zorinos.com/premium jammy main
deb-src https://packages.zorinos.com/premium jammy main

EOF
}

if [ "$version" = "16" ]; then
    # Add zorin16.list
    AddSources16
elif [ "$version" = "17" ]; then
    # Add zorin17.list
    AddSources17
else
    fail
fi

sleep 2

# Create a temporary directory and store its name in a variable.
TEMPD=$(mktemp -d)

# Exit if the temp directory wasn't created successfully.
if [ ! -e "$TEMPD" ]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

if [ -e "$TEMPD" ]; then
    sudo chmod 777 "$TEMPD"
fi

echo ""
echo "Adding Zorin's Package Keys..."
echo ""

# manually add the keyrings
curl -H 'DNT: 1' -H 'Sec-GPC: 1' https://ppa.launchpadcontent.net/zorinos/stable/ubuntu/pool/main/z/zorin-os-keyring/zorin-os-keyring_1.1_all.deb --output $TEMPD/zorin-os-keyring_1.1_all.deb
curl -H 'DNT: 1' -H 'Sec-GPC: 1' -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb --output $TEMPD/zorin-os-premium-keyring_1.0_all.deb
# fix permissions of manually downloaded keyrings
sudo chmod 777 "$TEMPD/zorin-os-keyring_1.1_all.deb"
sudo chmod 777 "$TEMPD/zorin-os-premium-keyring_1.0_all.deb"
sleep 1
sudo apt install ${apt_no_confirm} "$TEMPD/zorin-os-keyring_1.1_all.deb"
sudo apt install ${apt_no_confirm} "$TEMPD/zorin-os-premium-keyring_1.0_all.deb"
sleep 2

echo ""
echo "Adding premium flags..."
echo ""

# introduce premium user agent
sudo touch /etc/apt/apt.conf.d/99zorin-os-premium-user-agent
sudo tee /etc/apt/apt.conf.d/99zorin-os-premium-user-agent > /dev/null << 'EOF'
Acquire
{
  http::User-Agent "Zorin OS Premium";
};

EOF

sleep 2

echo ""
echo "Adding premium content..."
echo ""

# update packages
sudo apt-get update

if [ "$version" = "16" ]; then
    # install 16 pro content
    if [ "$extra" = "true" ]; then
        sudo apt-get install ${apt_no_confirm} zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-16 zorin-sound-theme zorin-windows-app-support-installation-shortcut
    else
        sudo apt-get install ${apt_no_confirm} zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-wallpapers zorin-os-wallpapers-16
    fi
elif [ "$version" = "17" ]; then
    # install 17 pro content
    if [ "$extra" = "true" ]; then
        sudo apt-get install ${apt_no_confirm} zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-pro-wallpapers-17 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-16 zorin-os-wallpapers-17 zorin-sound-theme zorin-windows-app-support-installation-shortcut
    else
        sudo apt-get install ${apt_no_confirm} zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-17 zorin-os-wallpapers zorin-os-wallpapers-17
    fi
else
    fail
fi
echo ""
echo ""
echo "All done!"
echo ""
echo 'Please Reboot your Zorin Instance... you can do so with "sudo reboot"'
echo ""
echo ""
