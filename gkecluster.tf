data "terraform_remote_state" "prod-tfstate" {
  backend = "gcs"
  config = {
    bucket  = "or2-m-epm-gcp-us-anthos-t1iylu-tfstate"
    prefix  = "prod"
  }
}

resource "google_container_cluster" "gke-cluster" {
  name               = "my-first-gke-cluster-jenkins"
  network            = "default"
  location           = "europe-west1-b"
  initial_node_count = 3
}
