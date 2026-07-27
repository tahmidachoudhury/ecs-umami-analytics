output "app_certificate_arn" {
  description = "The ACM certificate for the load balancer on HTTPS."
  value       = aws_acm_certificate_validation.app.certificate_arn
}

output "domain_validation_options" {
  value = aws_acm_certificate.cert.domain_validation_options
}

output "certificate_arn" {
  description = "ARN of the ACM certificate to be used by services such as ALB for HTTPS listeners."
  value       = aws_acm_certificate.cert.arn
}
