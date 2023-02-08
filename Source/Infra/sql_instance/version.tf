terraform {
  required_version = ">= 1.3.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      #version = "~> 4.42.0"
      version = ">= 4.42.0"
    }
  }
}