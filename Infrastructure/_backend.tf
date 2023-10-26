# Remote backend, depending on the scale of the project it's recommended to use a tool like Atlantis, Scalr or Terraform cloud
# as it allows to automate the management of the state file and the execution of the plan and apply commands
# terraform {
#   backend "gcs" {
#     bucket  = "tf-state-latam-infrastructure"
#     prefix  = "terraform/state"
#     project = "latam"
#   }
# }
