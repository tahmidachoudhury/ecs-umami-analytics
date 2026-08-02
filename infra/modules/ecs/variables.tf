variable "project_name" {
  type        = string
  description = "The name of the project, used for resource naming and tagging."
}

variable "environment" {
  type        = string
  description = "The deployment environment (dev or prod)"
}

variable "cpu" {
  type        = number
  description = "The unit of CPU that the task definition needs."
}

variable "memory" {
  type        = number
  description = "The unit of memory that the task definition needs."
}

variable "task_role_arn" {
  type        = string
  description = "The IAM role for allowing container task to call other AWS services."
}

variable "execution_role_arn" {
  type        = string
  description = "The IAM role for the ECS container agent and Docker deamon."
}

variable "aws_region" {
  type        = string
  description = "The AWS region of where the resources are deployed."
}

variable "cloudwatch_log_group_name" {
  description = "The CloudWatch log group name for container logs."
  type        = string
}

variable "number_of_tasks" {
  description = "The number of tasks being run in the ECS Service."
  type        = number
}

variable "alb_target_group_arn" {
  description = "The ALB target group that the ECS service registers with."
  type        = string
}

variable "container_port" {
  description = "The port the container listens on."
  type        = number
}

variable "bootstrap_image" {
  description = "Full image reference for the app container. Bootstrap value only; the deploy pipeline owns revisions after the first apply."
  type        = string
}

variable "ecs_sg_id" {
  type        = string
  description = "The ECS security group."
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs where ECS tasks will run."
  type        = list(string)
}

variable "db_secret_arn" {
  type        = string
  sensitive   = true
  description = "ARN of the Secrets Manager secret containing RDS master credentials (username and password)."
}

variable "db_host" {
  type        = string
  description = "RDS instance hostname."
}

variable "db_port" {
  type        = number
  description = "RDS instance port."
}

variable "db_name" {
  type        = string
  description = "RDS database name."
}
