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

 ```
git clone https://github.com/MAHALAKSHMImahalakshmi/terraform-multi-env.git
cd terraform-multi-env

terraform init

terraform workspace new dev # Run once per workspace (dev, prod, etc.)
terraform workspace select dev

terraform plan -var-file=environments/dev.tfvars
terraform apply -var-file=environments/dev.tfvars
```

---

## 🛠️ Environment Separation

- Isolated environments via Terraform Workspaces (`terraform workspace` commands)
- Unique variable definitions per environment in `environments/*.tfvars`
- Supports adding, updating, or destroying each environment independently

---

## 🚀 Deployment

1. **Switch to desired workspace**  
   `terraform workspace select <env>`
2. **Plan & apply with corresponding tfvars**  
   `terraform plan -var-file=environments/<env>.tfvars`  
   `terraform apply -var-file=environments/<env>.tfvars`

---

## 📁 Project Structure

| Path                   | Purpose                                        |
|------------------------|------------------------------------------------|
| `main.tf`              | Core Terraform resources and modules           |
| `variables.tf`         | Input variables definition                     |
| `environments/`        | Environment-specific `.tfvars` files           |
| `modules/`             | Shared/reusable Terraform modules              |
| `.gitignore`           | Excludes sensitive or rebuildable files        |
| `README.md`            | Project documentation                          |

---

## 💡 Best Practices

- Parameterize everything—never hard-code environment values
- Always use remote backend for production/team use
- Document modules and inputs thoroughly for easy onboarding
- Review state files and lock as needed for safety

---

