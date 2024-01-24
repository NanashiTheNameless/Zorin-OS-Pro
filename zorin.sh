#!/usr/bin/env bash

echo "███████╗ ██████╗ ██████╗ ██╗███╗   ██╗     ██████╗ ███████╗    ██████╗ ██████╗  ██████╗ "
echo "╚══███╔╝██╔═══██╗██╔══██╗██║████╗  ██║    ██╔═══██╗██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗"
echo "  ███╔╝ ██║   ██║██████╔╝██║██╔██╗ ██║    ██║   ██║███████╗    ██████╔╝██████╔╝██║   ██║"
echo " ███╔╝  ██║   ██║██╔══██╗██║██║╚██╗██║    ██║   ██║╚════██║    ██╔═══╝ ██╔══██╗██║   ██║"
echo "███████╗╚██████╔╝██║  ██║██║██║ ╚████║    ╚██████╔╝███████║    ██║     ██║  ██║╚██████╔╝"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝     ╚═════╝ ╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ "
echo "|ZORIN-OS-PRO| |Script v4.0.0| |Overhauled By NamelessNanasi/CortezJEL| |original by PEAKYCOMMAND|"
echo ""
echo "(Please note this version ONLY works on Zorin 17 and 16)"
echo "(to use this script on Zorin 16 add the -6 flag or -7 to manually override to zorin 17 although that should be redundant)"
echo "THIS CODE AND ACCOMPANYING DOCUMENTATION WERE OVERHAULED SIGNIFICANTLY BY NamelessNanashi/CortezJEL, \nIF YOU GOT THIS CODE ELSEWHERE KNOW THAT THE CODE SHOULD NOT BE FULLY TRUSTED DUE TO THE IMPROPER ETIQUETTE AND ACTIONS OF THE ORIGINAL DEV!"
echo "THIS CODE AND ACCOMPANYING DOCUMENTATION WERE OVERHAULED SIGNIFICANTLY BY NamelessNanashi/CortezJEL, \nIF YOU GOT THIS CODE ELSEWHERE KNOW THAT THE CODE SHOULD NOT BE FULLY TRUSTED DUE TO THE IMPROPER ETIQUETTE AND ACTIONS OF THE ORIGINAL DEV!"
sleep 10

# Prompt user
echo "Please Enter your sudo password!"

# Sudo echo so it always propts here
sudo echo > /dev/null

# Parse command line arguments for flag
OPTION_COUNT=0
while getopts "67" opt; do
  case $opt in
    6)
        sixteen="true"
    ;;
    7)
        sixteen="false"
    ;;
    esac
done
if [ "$OPTION_COUNT" -gt 1 ]; then echo "too many options"; fi

echo "Preparing to install dependencies..."

# Install ca-certificates
sudo apt-get install ca-certificates aptitude

sleep 2

echo "Updating the defaut source.list for Zorin's custom resources..."

if [ "$sixteen" = "true" ]; then   
            # Copy zorin16.list mod
            sudo cp -f ./zorin16.list /etc/apt/sources.list.d/zorin.list
            # Add the required apt-key to be safe
            curl -sS https://packages.zorinos.com/zorin_os_key.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zorin.gpg
            # sudo gpg --keyserver key server.ubuntu.com --recv-key  5FD7496A07D323BC
            # sudo gpg -a --export 5FD7496A07D323BC | sudo apt-key add -
elif  "$sixteen" = "false" ]; then
            # Copy zorin17.list mod
            sudo cp -f ./zorin17.list /etc/apt/sources.list.d/zorin.list
            # Add the required apt-key to be safe
            curl -sS https://packages.zorinos.com/zorin_os_key.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/zorin.gpg
            # sudo gpg --keyserver key server.ubuntu.com --recv-key  5FD7496A07D323BC
            # sudo gpg -a --export 5FD7496A07D323BC | sudo apt-key add -
else
            echo "You are not running this script correctly, read the GitHub https://github.com/CortezJEL/Zorin-OS-Pro/ for more info"
            exit 1
fi

sleep 2

echo "adding premium flags..."

# introduces premium user agent
sudo cp -f ./99zorin-os-premium-user-agent /etc/apt/apt.conf.d/

sleep 2

echo "Adding premium content..."

# update packages
sudo aptitude update

if [ "$sixteen" = "true" ]; then   
            # install 16 pro content
            sudo aptitude install zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-16
elif [ "$sixteen" = "false" ]; then
            # install 17 pro content
            sudo aptitude install zorin-os-pro zorin-os-pro-creative-suite zorin-os-pro-productivity-apps zorin-os-pro-wallpapers zorin-os-pro-wallpapers-17
else
            echo "You are not running this script correctly, read the GitHub https://github.com/CortezJEL/Zorin-OS-Pro/ for more info"
            exit 1
fi

echo "All done!"
echo 'Please Reboot your Zorin Instance... you can do so with "sudo reboot"'
