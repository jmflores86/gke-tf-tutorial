terraform {
  backend "gcs" {
    bucket = "or2-m-epm-gcp-us-anthos-t1iylu-tfstate"
    prefix = "prod"
  }
}
