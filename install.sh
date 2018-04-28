#!/usr/bin/env bash

# Safer bash scripts.
set -euo pipefail

##################################################################
# Timfrastructure install script for running in CI environments.
##################################################################

echo
echo Installing the latest version of Shellcheck...
curl --location --fail --silent https://storage.googleapis.com/shellcheck/shellcheck-stable.linux.x86_64.tar.xz > shellcheck.tar.xz
tar --xz -xvf shellcheck.tar.xz
shellcheck() { "${TRAVIS_BUILD_DIR}/shellcheck-stable/shellcheck" "$@"; }
export -f shellcheck

echo
echo Linting install script before starting, script will not run if there are problems...
shellcheck "${0}"

# @see https://github.com/hashicorp/terraform/issues/9803#issuecomment-257903082
echo Getting the latest available versions of Terraform and Packer...
HASHICORP_API_BASE="https://checkpoint-api.hashicorp.com/v1/check"
HASHICORP_RELEASE_BASE="https://releases.hashicorp.com"
TERRAFORM_LATEST="$(curl -s "${HASHICORP_API_BASE}"/terraform | jq -r -M '.current_version')"
PACKER_LATEST="$(curl -s "${HASHICORP_API_BASE}"/packer | jq -r -M '.current_version')"

echo
echo "Installing Terraform ${TERRAFORM_LATEST} and making it available as a command..."
echo
curl --location --fail --silent "${HASHICORP_RELEASE_BASE}/terraform/${TERRAFORM_LATEST}/terraform_${TERRAFORM_LATEST}_linux_amd64.zip" > terraform.zip
unzip terraform.zip
terraform() { "${TRAVIS_BUILD_DIR}/terraform" "$@"; }
export -f terraform

echo
echo "Installing Packer ${PACKER_LATEST} and making it available as a command..."
echo
curl --location --fail --silent "${HASHICORP_RELEASE_BASE}/packer/${PACKER_LATEST}/packer_${PACKER_LATEST}_linux_amd64.zip" > packer.zip
unzip packer.zip
packer() { "${TRAVIS_BUILD_DIR}/packer" "$@"; }
export -f packer

echo
echo Installing ansible-lint with pip...
echo
sudo pip2 install ansible-lint

echo
