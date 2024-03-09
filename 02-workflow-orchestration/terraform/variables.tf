variable "credentials" {
  default = "./service_account.json"
  type    = string
}

variable "project" {
  default = "speedy-league-416712"
  type    = string
}

variable "region" {
  default = "asia-southeast2"
  type    = string
}

variable "zone" {
  default = "asia-southeast2-b"
  type    = string
}

variable "email" {
  default = "de-zoomcamp@speedy-league-416712.iam.gserviceaccount.com"
  type    = string
}

variable "machine_type" {
  default = "e2-standard-2"
  type = string
}

variable "disk_size" {
  default = 20
  type = number
}