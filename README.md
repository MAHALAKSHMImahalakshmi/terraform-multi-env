# 🌍 Terraform Multi-Environment with Workspaces & tfvars

This project demonstrates managing multiple environments (dev, prod, qa, etc.) in Terraform using **workspaces**, **environment-specific tfvars files**, and **backend configuration** for scalable and isolated infrastructure deployments.

---

## 🛠️ Key Concepts: Terraform Workspaces & Environment Isolation

- **Terraform Workspaces:**  
  Enable multiple distinct state environments using the same codebase.  
  Example: `terraform.workspace` can hold values like `"dev"`, `"prod"`, etc.

- **tfvars Files:**  
  Environment-specific variables stored under `tfvars/{env}.tfvars` to parameterize deployments per environment.

- **Backend Configuration:**  
  Backend state stored remotely (e.g., S3), organized by workspace, ensuring isolated and safe state files per environment.  

---

## ⚙️ Workspace Basics & Commands

| Command                      | Description                          |
|-----------------------------|------------------------------------|
| `terraform workspace list`  | Lists all available workspaces      |
| `terraform workspace new dev`| Creates a new workspace called `dev` |
| `terraform workspace select prod` | Switches to the `prod` workspace    |
| `terraform workspace show`  | Shows the currently selected workspace |

- When you create a workspace, Terraform will maintain separate state files per environment (e.g., dev, prod).
- Selecting a workspace scopes your Terraform commands to that environment’s state.

---

## 🔍 Using Terraform Workspace in Code
```
resource "aws_instance" "example" {
instance_type = lookup(
{
dev = "t3.micro",
qa = "t3.small",
prod = "t3.large"
},
terraform.workspace,
"t3.micro"
)

ami = "ami-xxxxxx"
instance_id = "i-instanceid"
}
```

Using `terraform.workspace` in interpolation helps dynamically configure resources based on the current environment.

---

## 💾 Managing Backend & State per Environment

Backend configuration files are stored under each environment’s folder, e.g., `dev/backend.tf`, `prod/backend.tf`. This enables:

- State files saved under separate folders or prefixes in a remote backend (like S3 bucket) named by workspace.
- Safe isolation to prevent state overwrites between environments.

---

## 🚀 Typical Workflow per Environment

Initialize Terraform with backend config for the dev environment
terraform init -backend-config=dev/backend.tf

Plan applying with dev specific variables
terraform plan -var-file=dev/dev.tfvars

Apply changes in dev environment
terraform apply -var-file=dev/dev.tfvars -auto-approve

(Optional) Destroy environment safely
terraform destroy -var-file=dev/dev.tfvars -auto-approve

text

To switch to prod environment:

terraform init -reconfigure -backend-config=prod/backend.tf
terraform workspace select prod
terraform plan -var-file=prod/prod.tfvars
terraform apply -var-file=prod/prod.tfvars -auto-approve

text

---

## 🔄 Flowchart: Workspace & Backend Initialization
```
flowchart TD
  A(Start: Clone repo & select env) --> B(terraform init with backend-config)
  B --> C{Workspace exists?}
  C -- No --> D(terraform workspace new [env])
  D --> E(terraform workspace select [env])
  C -- Yes --> E
  E --> F(terraform plan with var-file)
  F --> G(terraform apply with var-file)
  G --> H(State saved in remote backend under [env] folder)
```


*Example*: `{env}` can be `dev`, `prod`, or `qa`.

---

## 🗂️ Folder Structure Overview

| Folder/File      | Description                                  |
|------------------|----------------------------------------------|
| `workspaces/`    | Contains workspace-specific backend configs  |
| `tfvars/`        | Environment variable definitions for tfvars  |
| `main.tf`        | Core Terraform configurations and resources  |
| `variables.tf`   | Variable declarations for dynamic config     |
| `outputs.tf`     | Outputs per environment                       |

---

## 🔑 Best Practices

- **Always use workspaces to isolate environments**—keep state files separate to avoid conflicts.
- Use **environment-specific `.tfvars` files** for clear and safe configuration management.
- **Keep backend config files per environment** for clean separation of state and secure remote storage.
- Use `terraform.workspace` interpolation to dynamically adjust resource parameters.
- Automate workspace creation and selection via scripts for safer CI/CD pipelines.

---

## 📦 Example Commands Summary

Create and switch to dev workspace
```
 terraform workspace new dev
terraform workspace select dev
```

Plan and apply in dev environment using tfvars
```
terraform plan -var-file=dev/dev.tfvars
terraform apply -var-file=dev/dev.tfvars -auto-approve
```
Switch to prod workspace and reinitialize backend
```
terraform init -reconfigure -backend-config=prod/backend.tf
```
terraform workspace select prod
```
terraform plan -var-file=prod/prod.tfvars
terraform apply -var-file=prod/prod.tfvars -auto-approve
```
