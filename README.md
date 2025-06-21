# Zorin-OS-Pro

## This script turns your Zorin OS CORE instance into a Zorin OS PRO instance!

## If you like the OS please consider supporting the original devs by buying a genuine copy!

### PLEASE NOTE: You will not receive support from <https://zorin.com/>. if you don't like that you can buy a copy.

You should have access to all Zorin OS Pro features.

## Stargazers over time

[![Stargazers over time](<https://starchart.cc/NanashiTheNameless/Zorin-OS-Pro.svg?variant=adaptive>)](<https://starchart.cc/NanashiTheNameless/Zorin-OS-Pro>)

# Usage:

Copy the command below, paste in your terminal, enter your password when prompted, follow the scripts' prompts, and reboow when it tells you to. You should now be running the pro version of Zorin OS!

### You can use the `-U` flag to do an unattended installation if needed.

### For Zorin 16

```sh
curl -sL https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh -o zorin.sh ; 
chmod +x zorin.sh ; 
bash zorin.sh -6 ; 
rm zorin.sh
```

### For Zorin 17

```sh
curl -sL https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh -o zorin.sh ; 
chmod +x zorin.sh ; 
bash zorin.sh -7 ; 
rm zorin.sh
```

## For A Lot of Extra Content

##### Zorin 16

```sh
curl -sL https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh -o zorin.sh ; 
chmod +x zorin.sh ; 
bash zorin.sh -6 -X ; 
rm zorin.sh
```

##### Zorin 17

```sh
curl -sL https://github.com/NanashiTheNameless/Zorin-OS-Pro/raw/refs/heads/main/zorin.sh -o zorin.sh ; 
chmod +x zorin.sh ; 
bash zorin.sh -7 -X ; 
rm zorin.sh
```

## If you face issues with the "zorin-os-premium-keyring" package try installing the deb manually using this command.

```sh
curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb --output zorin-os-premium-keyring_1.0_all.deb
sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
```

It should be okay to ignore further errors.

# Examples

(example images are taken of a Virtualbox image made from a core iso as it is easier to perform debugging of a took like this in a VM)

![Zorin OS Pro Appearance Menu](<https://github.com/user-attachments/assets/22945121-0e8c-44d4-ae81-dae49b62b662>)

![Zorin OS Pro Wallpaper Menu](<https://github.com/user-attachments/assets/18c1b89e-edf0-4c3b-bc8f-6784dff9f72e>)

![Zorin OS Pro Settings Menu](<https://github.com/user-attachments/assets/ab4e185f-9480-4a05-9fac-94d79f08dd82>)

# Credits

- NamelessNanashi/NanashiTheNameless For Overhauling And Adding Zorin OS 17 Support.
- AdityaGarg8 For Adding The -U Functionality, And Helping Me Notice And Fix many Oversights.
- kauancvlcnt For The Original Code And The Idea.
- [All Other Github Contributors For Their Appropriate Additions/Commits](<https://github.com/NanashiTheNameless/Zorin-OS-Pro/graphs/contributors>)
