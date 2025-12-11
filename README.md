# ECS-Project

This project delivers a fully automated, containerised deployment of the open-source <a href="https://github.com/usememos/memos"><strong>Memos</strong></a> application. Infrastructure is provisioned with Terraform; the application is built and deployed through CI/CD pipelines that handle the full lifecycle from build to destroy. It demonstrates an end-to-end DevOps workflow using infrastructure-as-code and automated orchestration.

### Project Overview

- The application is containerised with Docker and the images are pushed to Amazon ECR through automated build workflows.  
- Terraform provisions all infrastructure, with remote state management ensuring consistent and reliable deployments.  
- Amazon RDS is used to provide persistent and managed database storage for the application.  
- Route 53 manages DNS records and directs traffic to the deployed service.  
- CI/CD pipelines automate image builds, Terraform plan/apply, and the end-to-end deployment lifecycle.  
- The stack is fully reproducible; both infrastructure and application changes flow through the same automated process.  
- A dedicated destroy pipeline handles teardown, ensuring all AWS resources are removed cleanly and predictably.

## Architecture Diagram

<img width="2130" height="1423" alt="Cloud Architecture" src="https://github.com/user-attachments/assets/fe76b8f3-6109-4661-beb5-a6affd41f557" />



## Project Structure

```text

└── ECS-Project/
    ├── .github/workflows/
    │   ├── deploy.yaml
    │   ├── terraform-plan.yaml
    │   ├── terraform-apply.yaml
    │   └── terraform-destroy.yaml
    ├── terraform/
    │   ├── modules/
    │   │   ├── alb/
    │   │   ├── dns/
    │   │   ├── ecs/
    │   │   ├── iam/
    │   │   ├── rds/
    │   │   └── vpc/
    │   ├── main.tf
    │   ├── output.tf
    │   ├── variables.tf
    │   └── provider.tf
    ├── app/
    │   └── scripts/
    │       └── Dockerfile
    ├── README.md
    └── .gitignore

```
