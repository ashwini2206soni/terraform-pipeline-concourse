#!/bin/sh

set -e



echo "==> Init <=="
terraform init \
    -input=false \
    -no-color \
    -backend-config="credentials=${GCP_CREDENTIALS}" \
    ./Terraform

echo "==> Validate <=="
terraform validate -no-color ./Terraform



echo "==> Plan <=="
terraform plan \
    -input=false \
    -no-color \
    -var="credentials=${GCP_CREDENTIALS}" \
    ./Terraform
echo "==> Done <=="
