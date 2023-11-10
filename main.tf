terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "intrusion_detection_alerts_incident" {
  source    = "./modules/intrusion_detection_alerts_incident"

  providers = {
    shoreline = shoreline
  }
}