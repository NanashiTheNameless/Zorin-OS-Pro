#!/usr/bin/env bash

echo "███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ██║   ██║███████╗    ██████╔╝██████╔╝██║   ██║"
echo " ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║    ██║   ██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║    ╚██████╔╝███████║    ██║     ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v6.0.0| |Overhauled By NamelessNanasi/NanashiTheNameless| |original by PEAKYCOMMAND|"
echo ""
echo "(Please note this version ONLY works on Zorin 17 and 16)"
echo ""
echo "(to use this script on Zorin 16 add the -6 flag or -7 for zorin 17)"
echo "(add -M for more content)"
echo ""
echo "THIS CODE AND ACCOMPANYING DOCUMENTATION WERE OVERHAULED SIGNIFICANTLY BY NamelessNanashi/NanashiTheNameless, "
echo "IF YOU GOT THIS CODE ELSEWHERE KNOW THAT THE CODE SHOULD NOT BE FULLY TRUSTED DUE TO THE IMPROPER ETIQUETTE AND ACTIONS OF THE ORIGINAL DEV!"
echo ""
sleep 8

function fail() {
        echo ""
        echo "You are not running this script correctly, read the GitHub https://github.com/NanashiTheNameless/Zorin-OS-Pro/ for more info"
        echo ""
        exit 1
}

# Parse command line arguments for flag
while getopts "67M" opt; do
  case $opt in
    6)
        version="16"
    ;;
    7)
        version="17"
    ;;
    M)
        more="true"
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

# Install ca-certificates and aptitude
sudo apt-get install ca-certificates aptitude

sleep 2

echo ""
echo "Updating the defaut sources.list for Zorin's custom resources..."
echo ""

if [ "$version" = "16" ]; then   
    # Copy zorin16.list mod
    sudo \cp -f $(dirname "$(readlink -f "$0")")/zorin16.list /etc/apt/sources.list.d/zorin.list
elif [ "$version" = "17" ]; then
    # Copy zorin17.list mod
    sudo \cp -f $(dirname "$(readlink -f "$0")")/zorin17.list /etc/apt/sources.list.d/zorin.list
else
    fail
fi

sleep 2

echo ""
echo "Adding Zorin's Package Keys..."
echo ""

sudo \cp -n $(dirname "$(readlink -f "$0")")/zorin_apt-cdrom.gpg /etc/apt/trusted.gpg.d/
sudo \cp -n $(dirname "$(readlink -f "$0")")/zorin-os-premium.gpg /etc/apt/trusted.gpg.d/
sudo \cp -n $(dirname "$(readlink -f "$0")")/zorin-os.gpg /etc/apt/trusted.gpg.d/

sleep 2

echo ""
echo "adding premium flags..."
echo ""

# introduces premium user agent
sudo \cp -f $(dirname "$(readlink -f "$0")")/99zorin-os-premium-user-agent /etc/apt/apt.conf.d/

sleep 2

echo ""
echo "Adding premium content..."
echo ""

# update packages
sudo aptitude update ; sudo apt-get update

# Create a temporary directory and store its name in a variable.
TEMPD=$(mktemp -d)

# Exit if the temp directory wasn't created successfully.
if [ ! -e "$TEMPD" ]; then
    >&2 echo "Failed to create temp directory"
    exit 1
fi

# Make sure the temp directory gets removed on script exit.
trap "exit 1"           HUP INT PIPE QUIT TERM
trap 'rm -f "$TEMPD"'   EXIT

if [ "$version" = "16" ]; then
    # install 16 pro content
    if [ "$more" = "true" ]; then
        curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb $TEMPD
        sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
        sudo aptitude install zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-16 zorin-sound-theme zorin-windows-app-support-installation-shortcut 
    else
        curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb
        sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
        sudo aptitude install zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-wallpapers zorin-os-wallpapers-16
    fi
elif [ "$version" = "17" ]; then
    # install 17 pro content
    if [ "$more" = "true" ]; then
        curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb
        sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
        sudo aptitude install zorin-additional-drivers-checker zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-connect zorin-desktop-session zorin-desktop-themes zorin-exec-guard zorin-exec-guard-app-db zorin-gnome-tour-autostart zorin-icon-themes zorin-os-artwork zorin-os-default-settings zorin-os-docs zorin-os-file-templates zorin-os-keyring zorin-os-minimal zorin-os-overlay zorin-os-premium-keyring zorin-os-printer-test-page zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16 zorin-os-pro-wallpapers-17 zorin-os-restricted-addons zorin-os-standard zorin-os-tour-video zorin-os-upgrader zorin-os-wallpapers zorin-os-wallpapers-16 zorin-os-wallpapers-17 zorin-sound-theme zorin-windows-app-support-installation-shortcut
    else
        curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb
        sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
        sudo aptitude install zorin-appearance zorin-appearance-layouts-shell-core zorin-appearance-layouts-shell-premium zorin-appearance-layouts-support zorin-auto-theme zorin-icon-themes zorin-os-artwork zorin-os-keyring zorin-os-premium-keyring zorin-os-pro zorin-os-pro-wallpapers zorin-os-pro-wallpapers-17 zorin-os-wallpapers zorin-os-wallpapers-17
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
