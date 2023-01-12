#!/bin/bash
sudo apt-get update
locale
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
locale
sudo apt -y install python3-pip
sudo apt install ansible
sudo apt install openjdk-8-jdk
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >>  /etc/bash.bashrc
export PATH=$PATH:$JAVA_HOME/bin
echo PATH=$PATH:$JAVA_HOME/bin >>  /etc/bash.bashrc
git clone https://github.com/apache/incubator-openwhisk.git openwhisk
cd openwhisk/
(cd tools/ubuntu-setup && ./all.sh)
cd ansible
export OW_DB=CouchDB
export OW_DB_PROTOCOL=http
export OW_DB_HOST=10.20.14.190
export OW_DB_PORT=5984
export OW_DB_USERNAME=admin1
export OW_DB_PASSWORD=cZdg3qbSf
kM-2mfG3qr
export ENVIRONMENT=local
echo ENVIRONMENT=local >>  /etc/bash.bashrc
ansible-playbook -i environments/$ENVIRONMENT setup.yml
ansible-playbook -i environments/$ENVIRONMENT prereq.yml
cd /home/test/openwhisk/
./gradlew distDocker
cd ansible
ansible-playbook -i environments/$ENVIRONMENT couchdb.yml
ansible-playbook -i environments/$ENVIRONMENT initdb.yml
ansible-playbook -i environments/$ENVIRONMENT wipe.yml
ansible-playbook -i environments/$ENVIRONMENT openwhisk.yml
ansible-playbook -i environments/$ENVIRONMENT postdeploy.yml
ansible-playbook -i environments/$ENVIRONMENT apigateway.yml
ansible-playbook -i environments/$ENVIRONMENT routemgmt.yml
cd /home/test/openwhisk/bin
export PATH=$PATH:$PWD
echo PATH=$PATH:/home/test/openwhisk/bin >>  /etc/bash.bashrc