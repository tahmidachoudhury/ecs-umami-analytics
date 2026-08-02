variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "umami-ecs-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "aws_region" {
  type        = string
  description = "The AWS region of where the resources are deployed."
}

variable "bootstrap_image" {
  description = "Full image reference for the app container. Bootstrap value only; the deploy pipeline owns revisions after the first apply."
  type        = string
}

variable "domain_name" {
  description = "The domain name of the application that is registered on Route53."
  type        = string
}

variable "subdomain_name" {
  type        = string
  description = "The subdomain name of the application from Route53."
}

variable "engine" {
  type        = string
  description = "Database engine to use for the RDS instance (e.g. postgres)."
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine (e.g. 18.3)."
}

variable "instance" {
  type        = string
  description = "RDS instance class that defines compute and memory capacity (e.g. db.t3.micro)."
}

variable "storage_size" {
  type        = number
  description = "Allocated storage size in gigabytes for the RDS instance."
}

variable "storage_type" {
  type        = string
  description = "Type of storage to use for the RDS instance (e.g. gp2, gp3, io1)."
}

variable "cpu" {
  type        = number
  description = "CPU units allocated to the ECS task (e.g. 256 = 0.25 vCPU for Fargate)."
}

variable "memory" {
  type        = number
  description = "Amount of memory (in MB) allocated to the ECS task (e.g. 512 MB)."
}

variable "container_port" {
  type        = number
  description = "Port on which the container listens for incoming traffic."
}

variable "number_of_tasks" {
  type        = number
  description = "Desired number of ECS tasks (containers) to run in the service."
}
