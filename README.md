# Zorin-OS-Pro
# Please do not use the original authors code, they have not adequately documented the functionality of the script nor the changes to notation made by my overhaul!
This script turns your Zorin OS CORE instance into a Zorin OS PRO instance
## More info can be seen here: https://github.com/PEAKYCOMMAND/Zorin-OS-Pro/commit/456414cea17f27051c4ef17ac16901b0d980c666

You will have access to all Zorin OS Pro features

### PLEASE NOTE: you will not recieve support from https://zorin.com/ if you dont like that you can buy a copy.
<p align="center">
<img width="700" src="https://user-images.githubusercontent.com/91558914/184500559-7c74f6db-f82d-415f-b88a-c00e09c600e3.png">
</p>

<p align="center">
<img width="700" src="https://user-images.githubusercontent.com/91558914/184501028-9958ac42-0cfb-4870-bf56-8ce24e6437f0.png">
</p>

# Installation:
copy the command below, paste in your terminal, then put your password, then restart your computer when it completes and you now be running the pro version Zorin OS

### You can use `-U` to make it work on headless machnes or unattended

### For Zorin 16
```bash
git clone https://github.com/NanashiTheNameless/Zorin-OS-Pro.git && ./Zorin-OS-Pro/zorin.sh -6
```

### For Zorin 17
```bash
git clone https://github.com/NanashiTheNameless/Zorin-OS-Pro.git && ./Zorin-OS-Pro/zorin.sh -7
```

## For More Content
##### Zorin 16
```bash
git clone https://github.com/NanashiTheNameless/Zorin-OS-Pro.git && ./Zorin-OS-Pro/zorin.sh -6 -M
```
##### Zorin 17
```bash
git clone https://github.com/NanashiTheNameless/Zorin-OS-Pro.git && ./Zorin-OS-Pro/zorin.sh -7 -M
```

## If you face issues with "zorin-os-premium-keyring" install the deb manually using this command
```bash
curl -A 'Zorin OS Premium' https://packages.zorinos.com/premium/pool/main/z/zorin-os-premium-keyring/zorin-os-premium-keyring_1.0_all.deb --output zorin-os-premium-keyring_1.0_all.deb
sudo apt install ./zorin-os-premium-keyring_1.0_all.deb
```
It should be okay to ignore further errors

# Credits
- NamelessNanasi/NanashiTheNameless For Overhauling And Adding Zorin OS 17 Support
- PEAKYCOMMAND For The Original Code And The Idea (please note, this dev should not be fully trusted)
- [All Other Github Contributors For Their Appropreate Addidions/Commits](https://github.com/NanashiTheNameless/Zorin-OS-Pro/graphs/contributors)
