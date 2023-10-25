# Pub/Sub para ingesta de datos
resource "google_pubsub_topic" "topic" {
  name = var.topic_name
}

# Dataset de BigQuery para almacenamiento y análisis
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  location   = var.dataset_location
}

resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.service_location
  template {
    spec {
      containers {
        image = "${var.grc_repository_url}:${var.service_tag}"
        env {
          name  = "DATASET"
          value = google_bigquery_dataset.dataset.dataset_id
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# IAM binding para que Cloud Run pueda acceder a BigQuery
resource "google_project_iam_member" "run_bigquery_viewer" {
  project = var.project_id
  role    = var.bigquery_role
  member  = "serviceAccount:${google_cloud_run_service.service.status[0].url}"
}

output "cloud_run_url" {
  value = google_cloud_run_service.service.status[0].url
}
