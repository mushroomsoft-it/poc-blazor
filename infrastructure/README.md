# Infrastructure – Terraform EKS Project

This repository contains the complete Terraform-based infrastructure for the poc-blazor project on AWS.
The infrastructure is modular, uses remote state, and follows a strict execution order to safely provision all resources.

--------------------------------------------------------------------

PROJECT STRUCTURE

infrastructure/
├── access/            # EKS access entries and access policies
├── addons/
│   ├── core/          # Core addons (ALB Controller, cert-manager, etc.)
│   └── dns/           # DNS and HTTPS configuration (optional)
├── bootstrap/
│   ├── backend/       # S3 backend and DynamoDB for Terraform state
│   └── github-oidc/   # GitHub Actions OIDC and IAM roles
├── eks/               # EKS cluster and node groups
├── network/           # VPC, subnets, routing, IGW
├── shared/            # Shared variables and tfvars
│   ├── variables.tf
│   └── terraform.tfvars
└── README.md

Each folder represents an independent Terraform module with its own remote state.

--------------------------------------------------------------------

PREREQUISITES

- AWS account
- AWS CLI configured (aws configure)
- Terraform >= 1.5
- kubectl
- IAM permissions (Administrator or PowerUser)
- GoDaddy account (only if HTTPS/DNS is enabled)

--------------------------------------------------------------------

SHARED VARIABLES

All common variables are declared and assigned in:

shared/
- variables.tf
- terraform.tfvars

These variables are reused across all modules using the --var-file flag.

--------------------------------------------------------------------

EXECUTION ORDER (IMPORTANT)

The infrastructure MUST be applied in the following order.

--------------------------------------------------------------------
1. BOOTSTRAP – BACKEND

Creates the S3 bucket and DynamoDB table used as the Terraform remote backend.

Commands:

cd bootstrap/backend
terraform init
terraform apply --var-file=../../shared/terraform.tfvars

--------------------------------------------------------------------
2. BOOTSTRAP – GITHUB OIDC

Sets up GitHub Actions OIDC integration and IAM roles.

Commands:

cd bootstrap/github-oidc
terraform init
terraform apply --var-file=../../shared/terraform.tfvars

Both bootstrap modules use their own remote state.

--------------------------------------------------------------------
3. NETWORK

Creates the VPC, public subnets, route tables, and internet gateway.

Commands:

cd network
terraform init
terraform apply --var-file=../shared/terraform.tfvars

NOTE:
The path here is ../shared/terraform.tfvars (not ../../shared) because of folder depth.

--------------------------------------------------------------------
4. EKS

Creates the EKS cluster, node groups, KMS resources, and OIDC provider.

Commands:

cd eks
terraform init
terraform apply --var-file=../shared/terraform.tfvars

--------------------------------------------------------------------
5. ACCESS

Configures EKS access entries and associates cluster access policies
for IAM users and roles.

Commands:

cd access
terraform init
terraform apply --var-file=../shared/terraform.tfvars

--------------------------------------------------------------------
6. ADD-ONS – CORE

Installs core Kubernetes add-ons such as:
- AWS Load Balancer Controller
- cert-manager (optional)
- Required IAM roles and service accounts

Commands:

cd addons/core
terraform init
terraform apply --var-file=../../shared/terraform.tfvars

--------------------------------------------------------------------
7. ADD-ONS – DNS (OPTIONAL)

This module is ONLY required if HTTPS is enabled.

It configures:
- cert-manager ClusterIssuer
- GoDaddy DNS webhook
- DNS records for HTTPS

Commands:

cd addons/dns
terraform init
terraform apply --var-file=../../shared/terraform.tfvars

--------------------------------------------------------------------

HTTPS AND DNS (OPTIONAL)

If HTTPS is NOT required:

- Comment the following variables in shared/terraform.tfvars:
  - godaddy_api_key
  - godaddy_api_secret

- Do NOT apply the addons/dns module

- Comment or disable in addons/core:
  - cert-manager
  - secrets-manager
  - external-dns
  - Any HTTPS-related Helm charts

Without HTTPS, the platform will still work correctly using HTTP.

--------------------------------------------------------------------

REMOTE STATE NOTES

- Each module manages its own remote Terraform state
- State is stored in S3 and locked using DynamoDB
- Modules reference outputs from previous modules using terraform_remote_state

--------------------------------------------------------------------

VERIFICATION

After completing all steps, update kubeconfig:

aws eks update-kubeconfig --region us-east-1 --name poc-blazor-eks-cluster

Verify access:

kubectl get nodes
kubectl get pods -A

If access is denied, verify:
- IAM permissions
- EKS access entries
- AWS CLI identity (aws sts get-caller-identity)

--------------------------------------------------------------------

NOTES

- Always follow the execution order
- Never delete or recreate the backend accidentally
- Always use the shared terraform.tfvars file
- Apply DNS and HTTPS only when required
