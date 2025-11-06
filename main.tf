resource "google_storage_bucket" "no-public" {
  name          = "tf-githubdemo-bucket"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}