#!/usr/bin/env bash

set -euo pipefail

# Update stuff.
sudo apt-get update
sudo apt-get upgrade --assume-yes

# TODO: Set up new hostname.

# TODO: Change server timezone.

# TODO: Add new user.

# TODO: Disable password login.

# TODO: Set up Papertrail monitoring.

# TODO: Install the Amazon Simple Systems Manager agent.

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

# TODO: Install Travis, Heroku, LastPass, Papertrail and AWS cli's.

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

# TODO: Install nginx & set up a vhost and php-fpm.

# TODO: Set up HTTPS for nginx with a LetsEncrypt certificate.

# TODO: Install and set up a local WordPress site to manage tm.id.au.
