# Space Invaders

## 🚀 Overview

A simple Space Invaders Game. 

## 🛠 Usage
1. Build the game by running `npx love.js game build -c`
2. `cd terraform`
3. Create `variables.auto.tfvars` file and input the following variables
    ```bash
    region = "enter aws region"
    service = "argocd"
    domain  = "enter in the route53 domain"
    ```
4. `terraform init` > `terraform plan` > `terraform apply -auto-approve`