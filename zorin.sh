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
            else
                echo "Temp Directory \"$TEMPD\" was not deleted correctly; you need to manually remove it!"
            fi
            ;;
        *)
            echo "Warning: TEMPD=\"$TEMPD\" is outside /tmp/, refusing to delete for safety."
            ;;
    esac
fi
' EXIT

# Check if running on Zorin OS
if ! grep -q "Zorin OS" /etc/os-release; then
    echo "Error: This script only supports Zorin OS."
    exit 1
fi

echo "███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ██║   ██║███████╗    ██████╔╝██████╔╝██║   ██║"
echo " ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║    ██║   ██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║    ╚██████╔╝███████║    ██║     ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v9.1.1.1| |Overhauled & Maintained By NamelessNanasi/NanashiTheNameless| |original by kauancvlcnt|"
echo ""
echo "(Please note this version ONLY works on ZorinOS 18 Core*, ZorinOS 17 Core, and ZorinOS 16 Core)"
echo ""
echo "To use this script on:"
echo "ZorinOS 16 Core use the -6 flag"
echo "ZorinOS 17 Core use the -7 flag"
echo "ZorinOS 18 Core use the -8 flag"
echo ""
echo "If a flag is not speficied the script will try to guess"
echo ""
echo "(add -X for a lot of extra content, Recommended)"
echo "(add -U for unattended mode, Not recommended)"
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
while getopts "678XU" opt; do
  case $opt in
    6)
        version="16"
    ;;
    7)
        version="17"
    ;;
    8)
        version="18"
    ;;
    X)
        extra="true"
    ;;
    U)
        apt_no_confirm="-y"
    ;;
    *)
        fail
    ;;
  esac
done

# Automatic version detection if no flag provided
if [ -z ${version+x} ] ; then
    if grep -q "Zorin OS" /etc/os-release; then
        version_id=$(grep VERSION_ID /etc/os-release | cut -d '"' -f2 | cut -d '.' -f1)
        case "$version_id" in
            16) version="16" ;;
            17) version="17" ;;
            18) version="18" ;;
            *) fail ;;
        esac
    else
        fail
    fi
fi

echo ""
echo "Preparing to install dependencies..."
echo ""

# Install ca-certificates and curl (not strictly necessary)
if ! sudo apt-get update; then
    echo "Error: Failed to update apt repositories."
    # This should be non-blocking
    # exit 1
fi
if ! sudo apt-get install ${apt_no_confirm} ca-certificates curl; then
    echo "Error: Failed to install dependencies."
    # This should be non-blocking
    # exit 1
fi

echo ""
echo "Updating the default sources.list for Zorin's custom resources..."
echo ""

function AddSources16() {
sudo cp /etc/apt/sources.list.d/zorin.list /etc/apt/sources.list.d/zorin.list.bak 2>/dev/null || true
sudo rm -f /etc/apt/sources.list.d/zorin.list
sudo touch /etc/apt/sources.list.d/zorin.list
sudo tee /etc/apt/sources.list.d/zorin.list > /dev/null << 'EOF'
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
sudo cp /etc/apt/sources.list.d/zorin.list /etc/apt/sources.list.d/zorin.list.bak 2>/dev/null || true
sudo rm -f /etc/apt/sources.list.d/zorin.list
sudo touch /etc/apt/sources.list.d/zorin.list
sudo tee /etc/apt/sources.list.d/zorin.list > /dev/null << 'EOF'
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

function AddSources18() {
sudo cp /etc/apt/sources.list.d/zorin.list /etc/apt/sources.list.d/zorin.list.bak 2>/dev/null || true
sudo rm -f /etc/apt/sources.list.d/zorin.list
sudo touch /etc/apt/sources.list.d/zorin.list
sudo tee /etc/apt/sources.list.d/zorin.list > /dev/null << 'EOF'
deb https://packages.zorinos.com/stable noble main
deb-src https://packages.zorinos.com/stable noble main

deb https://packages.zorinos.com/patches noble main
deb-src https://packages.zorinos.com/patches noble main

deb https://packages.zorinos.com/apps noble main
deb-src https://packages.zorinos.com/apps noble main

deb https://packages.zorinos.com/drivers noble main restricted
deb-src https://packages.zorinos.com/drivers noble main restricted

deb https://packages.zorinos.com/premium noble main
deb-src https://packages.zorinos.com/premium noble main

EOF
}

if [ "$version" = "16" ]; then
    AddSources16
elif [ "$version" = "17" ]; then
    AddSources17
elif [ "$version" = "18" ]; then
    AddSources18
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
    sudo chmod 755 "$TEMPD"
fi

echo ""
echo "Adding Zorin's Package Keys..."
echo ""

# Manually add the keyrings
if ! curl -H 'DNT: 1' -H 'Sec-GPC: 1' https://ppa.launchpadcontent.net/zorinos/stable/ubuntu/pool/main/z/zorin-os-keyring/zorin-os-keyring_1.1_all.deb --output "$TEMPD/zorin-os-keyring_1.1_all.deb"; then
    echo "Error: Failed to download Zorin OS keyring."
    exit 1
fi
if [ ! -s "$TEMPD/zorin-os-keyring_1.1_all.deb" ]; then
    echo "Error: Downloaded Zorin OS keyring file is empty or missing."
    exit 1
fi

if [ "$version" = "18" ]; then
    if ! curl -H 'DNT: 1' -H 'Sec-GPC: 1' -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.1_all.deb --output "$TEMPD/zorin-os-premium-keyring_all.deb"; then
        echo "Error: Failed to download premium keyring."
        exit 1
    fi
    if [ ! -s "$TEMPD/zorin-os-premium-keyring_all.deb" ]; then
        echo "Error: Downloaded premium keyring file is empty or missing."
        exit 1
    fi
else
    if ! curl -H 'DNT: 1' -H 'Sec-GPC: 1' -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb --output "$TEMPD/zorin-os-premium-keyring_all.deb"; then
        echo "Error: Failed to download premium keyring."
        exit 1
    fi
    if [ ! -s "$TEMPD/zorin-os-premium-keyring_all.deb" ]; then
        echo "Error: Downloaded premium keyring file is empty or missing."
        exit 1
    fi
fi

# Fix permissions of manually downloaded keyrings
sudo chmod 644 "$TEMPD/zorin-os-keyring_1.1_all.deb"
sudo chmod 644 "$TEMPD/zorin-os-premium-keyring_all.deb"

if ! sudo apt --no-install-recommends install ${apt_no_confirm} "$TEMPD/zorin-os-keyring_1.1_all.deb"; then
    echo "Error: Failed to install Zorin OS keyring."
    exit 1
fi
if ! sudo apt --no-install-recommends install ${apt_no_confirm} "$TEMPD/zorin-os-premium-keyring_all.deb"; then
    echo "Error: Failed to install premium keyring."
    exit 1
fi

echo ""
echo "Adding premium flags..."
echo ""

# Introduce premium user agent
sudo rm -f /etc/apt/apt.conf.d/99zorin-os-premium-user-agent
sudo touch /etc/apt/apt.conf.d/99zorin-os-premium-user-agent
sudo tee /etc/apt/apt.conf.d/99zorin-os-premium-user-agent > /dev/null << 'EOF'
Acquire
{
  http::User-Agent "Zorin OS Premium";
};

EOF

echo ""
echo "Adding premium content..."
echo ""

# Update packages
if ! sudo apt-get update; then
    echo "Error: Failed to update apt repositories after adding sources."
    # This should be non-blocking
    # exit 1
fi

if [ "$version" = "16" ]; then
    # install 16 pro content
    if [ "$extra" = "true" ]; then
        if ! sudo apt-get install ${apt_no_confirm} zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-12 zorin-os-wallpapers-15 zorin-os-wallpapers-16 zorin-sound-theme zorin-windows-app-support-installation-shortcut; then
            echo "Error: Failed to install packages."
            exit 1
        fi
    else
        if ! sudo apt-get --no-install-recommends install ${apt_no_confirm} zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-wallpapers zorin-os-wallpapers-16; then
            echo "Error: Failed to install packages."
            exit 1
        fi
    fi
elif [ "$version" = "17" ]; then
    # install 17 pro content
    if [ "$extra" = "true" ]; then
        if ! sudo apt-get install ${apt_no_confirm} zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-pro-wallpapers-17 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-12 zorin-os-wallpapers-15 zorin-os-wallpapers-16 zorin-os-wallpapers-17 zorin-sound-theme zorin-windows-app-support-installation-shortcut; then
            echo "Error: Failed to install packages."
            exit 1
        fi
    else
        if ! sudo apt-get --no-install-recommends install ${apt_no_confirm} zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-17 zorin-os-wallpapers zorin-os-wallpapers-17; then
            echo "Error: Failed to install packages."
            exit 1
        fi
    fi
elif [ "$version" = "18" ]; then
    # install 18 pro content
    if [ "$extra" = "true" ]; then
        if ! sudo apt-get install ${apt_no_confirm} zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-pro-wallpapers-17 zorin-os-pro-wallpapers-18 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-12 zorin-os-wallpapers-15 zorin-os-wallpapers-16 zorin-os-wallpapers-17 zorin-os-wallpapers-18 zorin-sound-theme zorin-windows-app-support-installation-shortcut; then
            echo "Error: Failed to install packages."
            exit 1
        fi
    else
        if ! sudo apt-get --no-install-recommends install ${apt_no_confirm} zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-18 zorin-os-wallpapers zorin-os-wallpapers-18; then
            echo "Error: Failed to install packages."
            exit 1
        fi
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
