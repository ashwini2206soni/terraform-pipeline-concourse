terraform {
  backend "gcs" {
    bucket      = "react_demo_tfstate"
    credentials = var.credentials
  }
}