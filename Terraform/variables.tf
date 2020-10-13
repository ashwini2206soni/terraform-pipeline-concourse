variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-f"
}

variable "project_name" {
  default = "reactdemo-291116"
}

# variable "credentials_file_path" {
#   description = "Path to the JSON file used to describe your account credentials"
#   default     = "~/credentials.json"
# }
variable "credentials" {
  description = "credentials"
}
variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/gcloud_id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/gcloud_id_rsa"
}
variable "tag"{
  description ="Docker image tag"
}