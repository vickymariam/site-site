terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.17.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.86.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "perizersandbox"
}

provider "azurerm" {
  features {}
}