#!/usr/bin/env bash

# shellcheck disable=SC2317  # Don't warn about unreachable commands
# shellcheck disable=SC2016  # Don't warn that expressions don't expand in single quotes

#################################################################################
echo ""
echo "This tool is not stable/not safe, only use this if you know what you doing!"
echo "(you will need to edit this script to enable it)"
echo ""
#################################################################################
# If you accept that this is not for real use you can comment out the line below.
exit 1
#################################################################################

# Download Keys from the Ubuntu KeyServer
tmp="$(mktemp)"
sudo apt-get update 2>&1 | sed -En 's/.*NO_PUBKEY ([[:xdigit:]]+).*/\1/p' | sort -u > "${tmp}"
cat "${tmp}" | xargs sudo gpg --keyserver "hkps://keyserver.ubuntu.com:443" --recv-keys  # to /usr/share/keyrings/*
cat "${tmp}" | xargs -L 1 sh -c 'sudo gpg --yes --output "/etc/apt/trusted.gpg.d/$1.gpg" --export "$1"' sh  # to /etc/apt/trusted.gpg.d/*
rm "${tmp}"

# Download Keys from the Debian KeyServer
tmp="$(mktemp)"
sudo apt-get update 2>&1 | sed -En 's/.*NO_PUBKEY ([[:xdigit:]]+).*/\1/p' | sort -u > "${tmp}"
cat "${tmp}" | xargs sudo gpg --keyserver "hkps://keyring.debian.org:443" --recv-keys  # to /usr/share/keyrings/*
cat "${tmp}" | xargs -L 1 sh -c 'sudo gpg --yes --output "/etc/apt/trusted.gpg.d/$1.gpg" --export "$1"' sh  # to /etc/apt/trusted.gpg.d/*
rm "${tmp}"

# Add another KeyServer just to be safe
tmp="$(mktemp)"
sudo apt-get update 2>&1 | sed -En 's/.*NO_PUBKEY ([[:xdigit:]]+).*/\1/p' | sort -u > "${tmp}"
cat "${tmp}" | xargs sudo gpg --keyserver "hkps://keys.openpgp.org:443" --recv-keys  # to /usr/share/keyrings/*
cat "${tmp}" | xargs -L 1 sh -c 'sudo gpg --yes --output "/etc/apt/trusted.gpg.d/$1.gpg" --export "$1"' sh  # to /etc/apt/trusted.gpg.d/*
rm "${tmp}"
