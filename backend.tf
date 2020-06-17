terraform {
  backend "gcs" {
    bucket = "tim-home-tfstate"
    credentials = "./creds/terraform.json"
  }
}
