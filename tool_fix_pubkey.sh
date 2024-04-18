#!/bin/sh -e

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
