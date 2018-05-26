#!/usr/bin/env bash

# Safer bash scripts.
set -euo pipefail

##################################################################
# Timfrastructure install script for running in CI environments.
##################################################################

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

echo
echo "Installing Packer ${PACKER_LATEST} and making it available as a command..."
echo
curl --location --fail --silent "${HASHICORP_RELEASE_BASE}/packer/${PACKER_LATEST}/packer_${PACKER_LATEST}_linux_amd64.zip" > packer.zip
unzip packer.zip

echo
echo Installing ansible-lint with pip...
echo
pip install ansible-lint --upgrade --user

echo
echo Installing the AWS CLI with pip...
echo
pip install awscli --upgrade --user

echo
echo Installing the Datadog Python tools for use during Ansible runs...
echo
pip install datadog pyyaml --upgrade --user

# Because we're installing without sudo, we need to also make sure our user path is available for
# imports within Python code, as this is how Ansible's Datadog module works.
# @see https://github.com/ansible/ansible/blob/devel/lib/ansible/modules/monitoring/datadog_event.py
# @see https://stackoverflow.com/questions/38112756/how-do-i-access-packages-installed-by-pip-user
PYTHONPATH="$( python -c "import site; print( site.USER_SITE );" ):${PYTHONPATH}"
export PYTHONPATH

# @see https://docs.travis-ci.com/user/encrypting-files/#Manual-Encryption
echo
echo Decrypting encrypted Terraform vars...
find . -name "*.gpg" -print0 | xargs --null --replace="%" bash -c "echo && echo '%' && echo \"${TF_VARS_ENCRYPTION_PASSPHRASE}\" | gpg --passphrase-fd 0 '%'"

echo
