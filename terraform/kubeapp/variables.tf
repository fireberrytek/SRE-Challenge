variable "cluster" {
  default = "dynamic-enablement-cluster"
}

variable "app" {
  type        = string
  description = "Name of application"
  default     = "dynamic-enablement-app"
}

variable "zone" {
  default = "us-west1-c"
}

variable "docker-image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "fireberrytek/dynabler:latest"
}
