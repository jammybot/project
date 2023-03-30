terraform {
  required_version = ">=0.12"

  required_providers {
    google = {
        source  = "hashicorp/google"
        version = "~> 4.59.0"
    }
  }
}
provider "google" {
  credentials = "${file(var.GOOGLE_CREDS)}"
  project = "dev-ruler-377318"
  region = "europe-west2"
}