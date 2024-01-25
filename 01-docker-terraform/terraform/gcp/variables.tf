variable "credentials" {
  type = string
  default = "service_account.json"
}

variable "project" {
  type = string
  default = "de-laboratory"
}

variable "region" {
  type = string
  default = "asia-southeast2-b"
}

variable "gcs_bucket_name" {
  type = string
  default = "okza_zoomcamp_data"
}

variable "location" {
  type = string
  default = "asia-southeast2"
}

variable "dataset_name" {
  type = string
  default = "zoomcamp_dataset"
}