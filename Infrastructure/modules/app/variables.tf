variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región de GCP para recursos"
  type        = string
  default     = "us-central1"
}

variable "topic_name" {
  description = "Nombre del topic de Pub/Sub"
  type        = string
  default     = "latam-app-topic"
}

variable "dataset_id" {
  description = "ID del dataset de BigQuery"
  type        = string
}

variable "dataset_location" {
  description = "Ubicación del dataset de BigQuery"
  type        = string
  default     = "US"
}

variable "service_name" {
  description = "Nombre del servicio de Cloud Run"
  type        = string
}

variable "service_location" {
  description = "Ubicación del servicio de Cloud Run"
  type        = string
  default     = "us-central1"
}

variable "grc_repository_url" {
  description = "Imagen Docker para Cloud Run (e.g., gcr.io/tu-proyecto/tu-imagen:latest)"
  type        = string
}

variable "bigquery_role" {
  description = "Rol de IAM para que Cloud Run acceda a BigQuery"
  type        = string
  default     = "roles/bigquery.dataViewer"
}

variable "service_tag" {
    type = string
    description = "Service tag used to pull the image from GCR"
}

variable "dataset_table_id" {
    type = string
    description = "Dataset table id"
    default = "latam-table"
}