# Terraform GCP Bucket Demo

This repository demonstrates Terraform automation for Google Cloud Platform using GitHub Actions.

## Setup Instructions

### 1. Create Google Cloud Service Account

```bash
# Create service account
gcloud iam service-accounts create terraform-ci \
    --display-name="Terraform CI Service Account"

# Grant necessary permissions
gcloud projects add-iam-policy-binding gmzdev \
    --member="serviceAccount:terraform-ci@gmzdev.iam.gserviceaccount.com" \
    --role="roles/storage.admin"

# Create and download key
gcloud iam service-accounts keys create key.json \
    --iam-account=terraform-ci@gmzdev.iam.gserviceaccount.com
```

### 2. Configure GitHub Secrets

Go to your repository settings → Secrets and variables → Actions, and add:

- `GCP_PROJECT_ID`: `gmzdev`
- `GCP_SA_KEY`: Contents of the `key.json` file

### 3. Local Development

```bash
# Copy example file
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
# Run terraform
terraform init
terraform plan
terraform apply
```

## What it creates

- Google Cloud Storage bucket with public access prevention
- Located in US region
- Force destroy enabled for easy cleanup

## CI/CD Workflow

- **Pull Requests**: Runs `init`, `fmt`, `validate`, `plan`
- **Main branch pushes**: Runs all steps + `apply`