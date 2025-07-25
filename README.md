# 🌱 terraform-multi-env

A robust template for managing multiple environments (dev, staging, prod) in Terraform using workspaces and `.tfvars` for safe, scalable IaC deployments.

---

## 🏗️ Architecture & Workflow

- Single Terraform codebase supports multiple isolated environments via workspaces.
- Each environment is parameterized with dedicated `.tfvars` files.
- Uses modules for reusable infrastructure logic.

**Workflow**:
1. Select or create a workspace for your environment.
2. Apply the relevant `*.tfvars` file for environment-specific configuration.
3. Remote backend support suggested for state isolation and team safety.

---

## ⚡ Quick Setup

bash ```
git clone https://github.com/MAHALAKSHMImahalakshmi/terraform-multi-env.git
cd terraform-multi-env

terraform init

terraform workspace new dev # Run once per workspace (dev, prod, etc.)
terraform workspace select dev

terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```
