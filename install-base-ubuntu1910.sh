#!/bin/bash

CURRENTUSER='casual'

function configurePATH {
	echo PATH='$PATH':/home/${CURRENTUSER}/.local/bin:/home/${CURRENTUSER}/go/bin >> /home/${CURRENTUSER}/.bashrc
}

function installSublime {
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install sublime-text
}

function getScannerInQL {
	#https://github.com/doyensec/inql
	wget https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.2/jython-standalone-2.7.2.jar
	wget https://github.com/doyensec/inql/releases/download/v1.0.0/inql_burp.py
	mv ./jython-standalone-2.7.2.jar /home/${CURRENTUSER}/Documents/
	mv ./inql_burp.py /home/${CURRENTUSER}/Documents/
	chown ${CURRENTUSER}:${CURRENTUSER} /home/${CURRENTUSER}/Documents/jython-standalone-2.7.2.jar
	chown ${CURRENTUSER}:${CURRENTUSER} /home/${CURRENTUSER}/Documents/inql_burp.py
}

function installPipx {
	python3 -m pip install -U pipx
	#echo PATH=${PATH}:/home/${CURRENTUSER}/.local/bin >> /home/${CURRENTUSER}/.bashrc
}

function installWfuzz {
	sudo apt install libcurl4-openssl-dev
	sudo pip3 install --upgrade wfuzz
}

function getWordLists {
	[[ ! -d /opt/words ]] && sudo mkdir /opt/words
	sudo chown "${CURRENTUSER}:${CURRENTUSER}" /opt/words
	cd /opt/words
	[[ ! -d /opt/words/SecLists ]] && git clone https://github.com/danielmiessler/SecLists.git
	[[ ! -d /opt/words/fuzzdb ]] && git clone https://github.com/fuzzdb-project/fuzzdb.git
}

function installGobuster {
	go get github.com/OJ/gobuster
}

sudo apt get update -y

sudo apt install -y \
	terminator \
	vim \
	git \
	docker \
	docker-compose \
	tshark \
	wireshark \
	wget \
	golang \
	forensics-all \
	libimage-exiftool-perl \
	ipython3 \
	python3-pip \
	python3-venv \
	nmap \
	ncat \
	whatweb \
	keepassx \
	vlc

sudo usermod -a -G wireshark ${CURRENTUSER}
sudo usermod -a -G docker ${CURRENTUSER}

sudo systemctl enable docker

installSublime
#getScannerInQL
getWordLists
installGobuster
installWfuzz
configurePATH

  #  94  mitmproxy 
  #  95  mitmproxy -V
  #  96  mitmproxy --version
  #  97  sudo apt remove mitmproxy
  #  98  
  #  99  vim ~/.bashrc 
  # 100  echo PATH
  # 101  echo $PATH
  # 102  pipx install mitmproxy
  # 103  sudo apt install python3-venv
  # 104  pipx install mitmproxy
  # 105  history 
