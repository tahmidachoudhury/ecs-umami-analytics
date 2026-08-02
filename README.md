# Umami Analytics: Deployed via AWS ECS Fargate and IaC

This project deploys a Dockerised analytics application to AWS ECS Fargate using Terraform and GitHub Actions CI/CD. It includes networking, load balancing, HTTPS, PostgreSQL, observability, and modular infrastructure configuration.

I built this project to showcase my cloud, networking, and infrastructure skills. I chose Umami because I had already used it for hosted frontend projects.

---

### Table of Contents

- [Demo](#demo)
- [Architecture](#architecture)
- [Infrastructure Components](#infrastructure-components)
- [Repository Structure](#repository-structure)
- [Features](#features)
- [Local Development](#how-to-set-up-locally)
- [CI/CD](#cicd)
- [Author](#author)

---

## Demo

> URL: https://analytics.tahmidchoudhury.uk

![ECS demo video](./docs/ecs-demo.gif)

---

## Architecture

![Architecture Diagram](./docs/ecs-v1-project.drawio.png)

The infrastructure is designed for high availability, security, and scalability.

---

## Infrastructure Components

| Component        | Details                                                                |
| ---------------- | ---------------------------------------------------------------------- |
| VPC              | Custom VPC with public and private subnets across 2 availability zones |
| Public Subnets   | 2 public subnets hosting the ALB and NAT Gateway                       |
| Private Subnets  | 2 private subnets hosting ECS Fargate tasks                            |
| Internet Gateway | Public internet access for the ALB                                     |
| NAT Gateway      | Outbound internet access for ECS tasks in private subnets              |
| ALB              | Application Load Balancer with HTTP to HTTPS redirect                  |
| ACM              | SSL certificate for HTTPS with Route53 DNS validation                  |
| ECS Fargate      | Containerised app running on serverless compute                        |
| ECR              | Docker image repository                                                |
| IAM              | ECS task execution role and task service role with least privilege     |
| CloudWatch       | Container log groups and log streaming for observability               |
| Route53          | DNS management and ACM certificate validation                          |
| S3               | Terraform remote state storage with native state locking               |

---

## Security

- Only approved admins can trigger workflows through GitHub Environments
- ECS tasks run in private subnets with no public IP assigned
- IAM least privilege roles scoped to only required permissions
- OIDC authentication in CI/CD pipeline eliminates long-lived AWS credentials
- Multi-stage Docker build minimises attack surface and image size
- HTTPS enforced across all traffic, HTTP redirects to HTTPS
- Security groups restrict ECS task access to ALB only

---

## Repository Structure

```sh
app
├── docker-compose.yml
├── Dockerfile
└── src
    └── app
        └── api
            └── heartbeat
...
infra
├── bootstrap
│   ├── main.tf
│   ├── modules
│   │   └── ecr
│   │   └── s3
│   ├── provider.tf
│   └── variables.tf
├── envs
├── modules
│   ├── acm
│   ├── alb
│   ├── secrets
│   ├── cloudwatch
│   ├── dns
│   ├── ecs
│   ├── iam
│   ├── networking
│   ├── rds
│   └── security_groups
├── backend.tf
├── main.tf
├── outputs.tf
└── variables.tf
.github
└── workflows
    ├── docker-build-push.yml
    ├── terraform-apply.yml
    ├── terraform-destroy.yml
    └── terraform-plan.yml
```

---

## Features

- Reduced application image from 3GB to 770MB with multi-stage Docker build
- Immutable, SHA-tagged container images in ECR
- Zero-touch ECS deploys with automatic rollback on failed health checks
- Terraform infrastructure seperated into modules for reusability and easy debugging
- Terraform state managed remotely via S3 with native state locking
- IAM roles follow least privilege principle throughout
- CI/CD workflows require admin approval before being triggered
- Custom VPC with private subnets for ECS tasks and RDS, public ingress only via ALB
- Observability and monitoring over RDS and ECS tasks with AWS CloudWatch

## How to set up locally

### 1. Clone the repository

```bash
# By HTTPS
git clone https://github.com/tahmidachoudhury/ecs-umami-analytics.git
# OR by SSH
git clone git@github.com:tahmidachoudhury/ecs-umami-analytics.git

cd ecs-umami-analytics
```

### 2. Create an environment file

Create a `.env` file in the root of the project:

```bash
touch .env
```

Add the required environment variables:

```env
DATABASE_URL=postgresql://umami:umami@db:5432/umami
APP_SECRET=your-random-secret
```

### 3. Start the application

The Docker Compose file contains everything needed to run the app locally.

```bash
docker compose up --build
```

### 4. Open the app

Once the containers are running, visit:

```text
http://localhost:3000
```

### 5. Stop the application

```bash
docker compose down
```

### 6. Remove volumes and reset the database

Use this if you want a clean local reset:

```bash
docker compose down -v
```

---

## CI/CD

### 1. Docker Build & Push

![docker build & push cicd](./docs/cicd/docker-build-push.png)

#### 1a. Docker Build

![docker build](./docs/cicd/docker-build.png)

#### 1b. Push to ECR

![Push to ECR](./docs/cicd/push-to-ecr.png)

---

### 2. Terraform Plan

![Terraform Plan](./docs/cicd/tf-plan.png)

#### 2a. Terraform Plan Steps

![Terraform Plan Steps](./docs/cicd/tf-plan-2.png)

---

### 3. Terraform Apply

![Terraform Apply](./docs/cicd/tf-apply.png)

#### 3a. Terraform Apply Steps

![Terraform Apply Steps](./docs/cicd/tf-apply-steps.png)

#### 3b. Post Deploy Check

![Terraform Apply Steps](./docs/cicd/tf-apply-check.png)

---

### 4. Terraform Destroy

![Terraform Destroy](./docs/cicd/tf-destroy.png)

#### 4a. Terraform Destroy Steps

![Terraform Destroy Steps](./docs/cicd/tf-destroy-2.png)

---

## Author

**Tahmid Choudhury** - DevOps Engineer

---

### **Connect**

<p align="center">
  <a href="https://www.linkedin.com/in/t-a-choudhury/" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/LinkedIn-%230A66C2.svg?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  <a href="https://www.tahmidchoudhury.uk" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/Portfolio-000000?style=for-the-badge&logo=vercel&logoColor=white" alt="Portfolio"/>
  </a>
  <a href="https://github.com/tahmidachoudhury" target="_blank" rel="noopener noreferrer">
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  </a>
</p>
