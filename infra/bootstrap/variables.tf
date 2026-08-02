variable "project_name" {
  description = "The name of the project. Used as a prefix for all resource names."
  type        = string
  default     = "umami-ecs-app"
}

variable "environment" {
  description = "Deployment environment (dev, staging, or prod)."
  type        = string
}

variable "region" {
  description = "Region for infrastructure deployment."
  type        = string
  default     = "eu-west-2"
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository."
  type        = string
  # OPTIONS: MUTABLE, IMMUTABLE, IMMUTABLE_WITH_EXCLUSION, or MUTABLE_WITH_EXCLUSION
  default = "IMMUTABLE"
}

variable "bucket_name" {
  description = "The name of the s3 bucket"
  type        = string
  default     = "umami-ecs-terraform-state"
}
