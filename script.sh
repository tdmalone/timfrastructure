#!/usr/bin/env bash

# Safer bash scripts.
set -euo pipefail

##################################################################
# Timfrastructure test script for running in CI environments.
# Requires pip2 and Docker. Assumes ./install.sh was run first.
##################################################################

# TODO: Potentially enhance script to not always use set -e, but instead to allow (most?) commands
#       to fail, storing the exit code. At the end, if any of the exit codes were non-zero, then
#       exit the entire script. To help track down the problem command, it should probably also show
#       a coloured notice after it runs.

# This script uses find and xargs a lot to perform operations within directories containing
# Terraform files. Whenever possible, null terminators are used for safety in supporting a wider
# variety of file and directory naming. Take suitable care when operating on any piped output to
# ensure inputs are handled with null terminators as the delimiters! When results are stored in a
# string, they're stored as a hex dump using xxd to retain the null terminators. xxd -revert is
# needed to do the opposite on retrieval.

echo
echo "External IP address of build machine:" "$( curl --silent http://api.ipify.org )"
echo
echo Linting test script before starting, script will not run if there are problems...
shellcheck "${0}"

echo
echo Finding all Terraform directories and Packer templates...
# shellcheck disable=SC2016 # We intentionally don't want the $(dirname) to expand until it's run.
TERRAFORM_DIRS="$( find . -name "*.tf" -print0 | xargs --null --replace="%" bash -c 'printf $( dirname "%" )\\0' | sort --zero-terminated | uniq --zero-terminated | xxd )"
PACKER_TEMPLATES="$( find . -name "packer-*.json" -print0 | sort --zero-terminated | xxd )"

echo Checking that Terraform files are formatted correctly...
terraform fmt -check

echo
echo Initialising Terraform directories...
# We output the directory name before init, and send stdout away as we only need see errors.
echo "${TERRAFORM_DIRS}" | xxd -revert | xargs --null --replace="%" bash -c 'echo "%" && ( cd "%" && terraform init -input=false -lock=false > /dev/null )'

echo
echo Validating all Terraform files...
echo "${TERRAFORM_DIRS}" | xxd -revert | xargs --null --replace="%" bash -c 'echo "%" && ( cd "%" && terraform validate )'

echo
echo Peforming additional checks on Terraform files using tflint...
# Note: an easy way to test tflint is working is to set an invalid EC2 instance type.
# shellcheck disable=SC2016 # We intentionally don't want $(pwd) to expand until it's run.
echo "${TERRAFORM_DIRS}" | xxd -revert | xargs --null --replace="%" bash -c 'echo && echo "%" && docker run --rm --tty --volume "$( pwd )/%":/data wata727/tflint --error-with-issues'

# Check that the state is up-to-date - i.e. that no changes have been pushed without being applied.
# We only care about the exit code here, and don't want to expose any potentially sensitive data,
# so we also redirect the output. We print out the exit code, though, so we know exactly which
# directory needs applying, and then rely on xargs to exit appropriately once it's done.
echo
echo "Checking there are no outstanding changes to be applied (changes will be hidden for security reasons)..."
# shellcheck disable=SC2016 # We intentionally don't want to expand below until run.
echo "${TERRAFORM_DIRS}" | xxd -revert | xargs --null --replace="%" bash -c '( cd "%" && terraform plan -detailed-exitcode -lock=false -no-color > tfplan; EXIT_CODE="${?}"; echo "%: ${EXIT_CODE}"; if [ "${EXIT_CODE}" != 0 ]; then aws sns publish --topic-arn="${SNS_ARN}" --message="$( cat tfplan )"; fi; exit "${EXIT_CODE}" )'

echo
echo Linting any shell scripts...
echo
find . -name "*.sh" -print0 | grep --null-data --invert-match "./script.sh" | xargs --null --replace="%" bash -c 'echo "%" && shellcheck "%"'

echo
echo Linting all Ansible playbooks...
echo
find . -name "*.yml" -print0 | grep --null-data --invert-match "./.travis.yml" | xargs --null ansible-lint -v

echo
echo Validating all Packer templates...
echo
# shellcheck disable=SC2016 # We intentionally don't want $(dirname) & $(basename) to expand yet.
echo "${PACKER_TEMPLATES}" | xxd -revert | xargs --null --replace="%" bash -c 'echo -n "%: " && ( cd $( dirname "%" ) && packer validate $( basename "%" ) || ( echo && exit 1 ) )'

# TODO: Deregister these AMIs afterwards so that builds are idempotent.
echo
echo Building all Packer templates...
echo
# shellcheck disable=SC2016 # We intentionally don't want $(dirname) & $(basename) to expand yet.
echo "${PACKER_TEMPLATES}" | xxd -revert | xargs --null --replace="%" bash -c 'echo "%" && ( cd $( dirname "%" ) && packer build $( basename "%" ) )'

echo
echo Script complete.
echo
