# store terraform state file in s3
# terraform {
#   backend "3" {
#     bucket  = 
#     key     =
#     region  = 
#     profile =
#   }
# }



terraform {
  cloud {
    organization = "arterycloud"

    workspaces {
      name = "Networking"
    }
  }
}