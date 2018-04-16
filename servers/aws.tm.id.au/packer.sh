#!/usr/bin/env bash

set -euo pipefail

# Update stuff and install helpers.
sudo apt-get update
sudo apt-get upgrade --assume-yes
sudo apt-get install apt-transport-https

# TODO: Set up new hostname.

# TODO: Change server timezone.

# TODO: Add new user.

# TODO: Disable password login.

# TODO: Set up Papertrail monitoring.

# TODO: Install the Amazon Simple Systems Manager agent.

# TODO: Install Datadog agent.

# TODO: Copy across common Datadog configuration.

# TODO: Clone tdmalone/dotfiles.

# Install Node.js.
# @see https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl --location https://deb.nodesource.com/setup_9.x | sudo --preserve-env bash /dev/stdin
sudo apt-get install --assume-yes nodejs

# Install Yarn.
# @see https://yarnpkg.com/en/docs/install
curl https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add /dev/stdin
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# TODO: Install PHP, Python & PIP, Ruby, and Go.

# TODO: Install MariaDB.

# Install Travis CLI and enable autocomplete.
# @see https://stackoverflow.com/a/44851034/1982136
sudo gem install travis
echo "y" | travis --version

# Install Heroku CLI.
# @see https://devcenter.heroku.com/articles/heroku-cli#download-and-install
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install Papertrail CLI.
# @see https://github.com/papertrail/papertrail-cli
sudo gem install papertrail

# TODO: Install LastPass, Papertrail and AWS cli's.

# Install wp-cli.
# @see https://wp-cli.org/#installing
curl --remote-name https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Install Ansible.
# @see http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu
sudo apt-get install --assume-yes software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install --assume-yes ansible

# Install Terraform.
# TODO: Find a way to programmatically download or get the latest version number.
curl --location https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip > terraform.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/terraform

# Install Packer
# TODO: Find a way to programmatically download or get the latest version number.
curl --location https://releases.hashicorp.com/packer/1.2.2/packer_1.2.2_linux_amd64.zip > packer.zip
unzip packer.zip
sudo mv packer /usr/local/bin/packer

# Install gcloud CLI & kubectl.
# @see https://cloud.google.com/sdk/docs/#deb
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
sudo apt-get install kubectl

# TODO: Install minikube.
# @see https://github.com/kubernetes/minikube/releases

# Install Azure CLI.
# @see https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
sudo apt-get update && sudo apt-get install azure-cli

# Install IBM Cloud CLI.
wget https://clis.ng.bluemix.net/download/bluemix-cli/0.6.6/linux64
tar -zxvf linux64 && rm linux64
Bluemix_CLI/install_bluemix_cli

# TODO: Install nginx & set up a vhost and php-fpm.

# TODO: Set up HTTPS for nginx with a LetsEncrypt certificate.

# TODO: Install and set up a local WordPress site to manage tm.id.au.
