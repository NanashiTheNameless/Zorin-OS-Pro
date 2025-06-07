# Zorin-OS-Pro

## This script turns your Zorin OS CORE instance into a Zorin OS PRO instance

You will have access to all Zorin OS Pro features

### PLEASE NOTE: You will not receive support from https://zorin.com/. if you don't like that you can buy a copy.

![Zorin OS Pro Appearance Menu](https://github.com/user-attachments/assets/a4feef94-c3da-4ddc-a3b9-19cd07250790)

![Zorin OS Pro Wallpaper Menu](https://github.com/user-attachments/assets/eb4e6442-216b-483f-a01d-9866dc3100bc)

### If you like the OS please consider supporting the original devs by buying a genuine copy!

## Stargazers over time

[![Stargazers over time](https://starchart.cc/NanashiTheNameless/Zorin-OS-Pro.svg?variant=adaptive)](https://starchart.cc/NanashiTheNameless/Zorin-OS-Pro)

# Installation:
Copy the command below, paste in your terminal, then put your password, then restart your computer when it completes and you will now be running the pro version of Zorin OS!

### You can use `-U` to make it work on headless machines or do an unattended installation.

### For Zorin 16
```sh
curl -s -L https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh | bash -s -- -6
```

### For Zorin 17
```sh
curl -s -L https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh | bash -s -- -7
```

## For A Lot of Extra Content
##### Zorin 16
```sh
curl -s -L https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh | bash -s -- -6 -X
```
##### Zorin 17
```sh
curl -s -L https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh | bash -s -- -7 -X
```

## If you face issues with "zorin-os-premium-keyring" install the deb manually using this command
```sh
curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb --output zorin-os-premium-keyring_1.0_all.deb
sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
```
It should be okay to ignore further errors

# Credits
- NamelessNanashi/NanashiTheNameless For Overhauling And Adding Zorin OS 17 Support.
- AdityaGarg8 For Adding The -U Functionality And Helping Me Notice And Fix A Few Oversights.
- kauancvlcnt For The Original Code And The Idea.
- [All Other Github Contributors For Their Appropreate Addidions/Commits](https://github.com/NanashiTheNameless/Zorin-OS-Pro/graphs/contributors)
