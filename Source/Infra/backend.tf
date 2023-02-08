terraform {
  backend "gcs" {
    bucket = "tf-bookshelf-ianikeiev"
    prefix = "terraform/tfstate"
  }
}