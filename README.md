# Memos App on AWS ECS

This project delivers a fully automated, containerised deployment of the open-source <a href="https://github.com/usememos/memos"><strong>Memos</strong></a> application. Infrastructure is provisioned with Terraform; the application is built and deployed through CI/CD pipelines that handle the full lifecycle from build to destroy. It demonstrates an end-to-end DevOps workflow using infrastructure-as-code and automated orchestration.

### Project Overview

- ***Multi-stage Docker builds*** to produce small, secure runtime images with clean separation between build and execution stages.
- ***Terraform*** for Infrastructure as Code, enabling repeatable and version-controlled cloud environments.
- ***AWS ECS Fargate*** for serverless container orchestration, removing the need to manage EC2 instances.
- ***Amazon RDS*** for managed, highly available relational database storage.
- ***Remote Terraform state*** stored in ***Amazon S3***, with ***DynamoDB*** used for state locking and consistency.
- ***HTTPS / TLS*** termination for secure communication.
- ***AWS Secrets Manager*** for secure handling of credentials and sensitive configuration.
- ***CI/CD pipeline*** to automate build, test, and deployment of container images.

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
## Running the Application Locally

### Requirements

- Docker
- Docker Compose (v2)

### Start the Application

From the app/scripts, run:

```bash
docker compose up 
```
The application will be available at:

```
http://localhost:8081
```
The application persists data using a Docker-managed volume, so data is retained across container restarts.

### Stop the Application

```bash
docker compose down 
```
## CI/CD workflows
- **Build and Push to ECR**
<img width="2855" height="1269" alt="image" src="https://github.com/user-attachments/assets/95a6c453-7394-4602-842e-1ba4736cabeb" />

- **Terraform Plan**
<img width="2842" height="1428" alt="image" src="https://github.com/user-attachments/assets/c790e3d5-55ac-43a3-8698-e7c38d316884" />

- **Terraform Apply**
<img width="2848" height="1266" alt="image" src="https://github.com/user-attachments/assets/5fde9b72-a24e-45a9-bd5c-011b78ad3704" />

- **Terraform Destroy**
<img width="2842" height="1256" alt="image" src="https://github.com/user-attachments/assets/321a1db4-801f-4faa-999f-682ee417d971" />

## Screenshots

<img width="2877" height="1528" alt="image" src="https://github.com/user-attachments/assets/6a9fa162-6c40-4be3-bab6-09367aecd9eb" />

<img width="2875" height="1534" alt="image" src="https://github.com/user-attachments/assets/ba214cce-722a-4c03-98e7-2e1f7958d72b" />






