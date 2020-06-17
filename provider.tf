provider "google" {
  credentials = file("./creds/terraform.json")
  project     = "or2-m-epm-gcp-us-anthos-t1iylu"
  region      = "europe-west1"
}
