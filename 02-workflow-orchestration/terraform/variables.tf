variable "credentials" {
  default = "./service_account.json"
  type    = string
}

variable "project" {
  default = "de-laboratory"
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
  default = "de-zoomcamp@de-laboratory.iam.gserviceaccount.com"
  type    = string
}