variable "project" {
  default = "dynamic-enablement-7000"
}

variable "region" {
  default = "us-west1"
}

variable "zone" {
  default = "us-west1-c"
}

variable "cluster" {
  default = "dynamic-enablement-cluster"
}

variable "nodepool" {
  default = "dynamic-enablement-nodepool"
}

variable "credentials" {
  default = "~/.ssh/fireberry-dynamic-enablement-gcp-account.json"
}

variable "kubernetes_min_ver" {
  default = "latest"
}

variable "kubernetes_max_ver" {
  default = "latest"
}

variable "preemptible_nodes" {
  # TURN ON preemptible for higher risk tolerance(batch, pre-prod, etc) apps to save $$$.
  default = true
}

variable "machine_type" {
  default = "e2-medium"
}

variable "team_name" {
  default = "de-devops"
}

variable "app_name" {
  default = "dynamic-enablement-app"
}
