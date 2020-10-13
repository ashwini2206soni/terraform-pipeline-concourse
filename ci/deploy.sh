#!/bin/sh

set -e

# move concourse parameters into files for terraform consumption



ssh-keygen -f ~/.ssh/gcloud_id_rsa -N ""
echo "==> Init <=="
terraform init \
    -backend-config="credentials=${GCP_CREDENTIALS}" \
    -input=false \
    -no-color \
    ./Terraform



echo "==> Plan <=="
terraform plan \
    -out=main.tfplan \
    -var="credentials=${GCP_CREDENTIALS}" \
    -var="tag=latest"\
    -input=false \
    -no-color \
    ./Terraform



echo "==> Apply <=="
terraform apply \
    -input=false \
    main.tfplan
echo "==> Done <=="
