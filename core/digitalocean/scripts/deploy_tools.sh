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
apt-get install -y build-essential
wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.profile

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export GOMODCACHE="/root/go/pkg/mod"
export GOPATH="/root/go"
export GOCACHE="/root/.cache/go-build"
export GOROOT="/usr/local/go"
export GOHOSTARCH="amd64"
export GOHOSTOS="linux"
export CGO_ENABLED="1"


# Amass
/usr/local/go/bin/go install -v github.com/owasp-amass/amass/v3/...@master

# Naabu
apt install -y libpcap-dev
/usr/local/go/bin/go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# ffuf
/usr/local/go/bin/go install github.com/ffuf/ffuf/v2@latest

# httpx
/usr/local/go/bin/go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Nuclei
/usr/local/go/bin/go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# Katana
/usr/local/go/bin/go install github.com/projectdiscovery/katana/cmd/katana@latest

# TruffleHog
git clone https://github.com/trufflesecurity/trufflehog.git
cd trufflehog; go install

# wordlist
mkdir ~/wordlists

cd ~/wordlists && git clone --depth 1 https://github.com/danielmiessler/SecLists.git

wget https://wordlists-cdn.assetnote.io/data/manual/2m-subdomains.txt
wget https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_parameters_top_1m_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_js_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_directories_1m_2022_12_28.txt
wget https://wordlists-cdn.assetnote.io/data/automated/httparchive_apiroutes_2022_12_28.txt

