#!/bin/bash -xe

# Add swap memory
fallocate -l 3G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf

apt update
wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
source ~/.bashrc
go version

# Amass
go install -v github.com/OWASP/Amass/v3/...@master

# Naabu
apt install -y libpcap-dev
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# ffuf
go install github.com/ffuf/ffuf/v2@latest

# wordlist
mkdir ~/wordlists

cd ~/wordlists && git clone --depth 1 https://github.com/danielmiessler/SecLists.git

wget https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_parameters_top_1m_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_js_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_directories_1m_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_apiroutes_2022_12_28.txt


