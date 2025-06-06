# Zorin-OS-Pro

#### Please do not use the original authors code, they have not adequately documented the functionality of the script nor the changes to notation made by my overhaul!

#### More info can be seen here: https://github.com/PEAKYCOMMAND/Zorin-OS-Pro/commit/456414cea17f27051c4ef17ac16901b0d980c666

## This script turns your Zorin OS CORE instance into a Zorin OS PRO instance

You will have access to all Zorin OS Pro features

### PLEASE NOTE: You will not receive support from https://zorin.com/ if you dont like that you can buy a copy.

![Zorin OS Pro Appearance Menu](https://github.com/user-attachments/assets/a4feef94-c3da-4ddc-a3b9-19cd07250790)

![Zorin OS Pro Wallpaper Menu](https://github.com/user-attachments/assets/eb4e6442-216b-483f-a01d-9866dc3100bc)

### If you like the OS please consider supporting the original devs by buying a genuine copy!

## Star History

<a href="https://www.star-history.com/#NanashiTheNameless/Zorin-OS-Pro&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=NanashiTheNameless/Zorin-OS-Pro&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=NanashiTheNameless/Zorin-OS-Pro&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=NanashiTheNameless/Zorin-OS-Pro&type=Date" />
 </picture>
</a>

# Installation:
opy the command below, paste in your terminal, then put your password, then restart your computer when it completes and you will now be running the pro version Zorin OS

### You can use `-U` to make it work on headless machnes or unattended

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
- NamelessNanashi/NanashiTheNameless For Overhauling And Adding Zorin OS 17 Support
- AdityaGarg8 For Adding The -U Functionality And Helping Me Notice And Fix A Few Oversights
- PEAKYCOMMAND For The Original Code And The Idea (please note, this dev should not be fully trusted)
- [All Other Github Contributors For Their Appropreate Addidions/Commits](https://github.com/NanashiTheNameless/Zorin-OS-Pro/graphs/contributors)
