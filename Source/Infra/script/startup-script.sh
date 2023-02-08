#! /bin/bash
sudo apt-get remove -y --purge man-db
sudo apt-get update
sudo apt-get -y install ansible git build-essential supervisor python3 python3-dev python3-pip libffi-dev libssl-dev
sudo git config --global credential.helper gcloud.sh
sudo git clone https://source.developers.google.com/p/gcp-2022-bookshelf-ianikeiev1/r/InstanceConfig /home/InstanceConfig/
# shellcheck disable=SC2155
sudo ansible-playbook /home/InstanceConfig/bookshelf.yml
