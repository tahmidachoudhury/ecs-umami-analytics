resource "aws_ecr_repository" "repo" {
  name                 = "${var.project_name}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability

  image_tag_mutability_exclusion_filter {
    filter      = "latest*"
    filter_type = "WILDCARD"
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-ecr"
    Environment = var.environment
  }
}

import {
  to = aws_s3_bucket.tf_state
  identity = {
    bucket = var.bucket_name
  }
}

resource "aws_s3_bucket" "tf_state" {
  provider = aws.ohio

  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}
