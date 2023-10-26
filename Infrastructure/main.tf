module "gcr" {
  source = "./modules/gcr"
  grc_repo_name = "latam-app"
}

module "app" {
  depends_on = [ 
    module.gcr 
  ]

  source = "./modules/app"
  project_id = "latam"
  dataset_id = "latam-app-dataset"
  service_name = "latam-app-service"
  grc_repository_url = module.gcr.grc_repository_url
  service_tag = "latest"
  }