provider "google" {
  credentials  = file(var.credentials)
  project      = var.project
  region       = var.regions
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  network  = var.network
  location = var.regions
  initial_node_count = var.initial_node_count
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.node_name
  location   = var.regions
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type
  }
}
