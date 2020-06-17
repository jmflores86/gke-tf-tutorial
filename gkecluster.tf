resource "google_container_cluster" "gke-cluster" {
  name               = "my-first-gke-cluster-2"
  network            = "default"
  location           = "europe-west1-b"
  initial_node_count = 3
}
