output "cert_validation_fqdns" {
  description = "FQDNs of the Route 53 DNS validation records created for ACM certificate validation."
  value = [
    for record in aws_route53_record.cert_validation : record.fqdn
  ]
}

output "app_url" {
  value = "https://${aws_route53_record.app.fqdn}"
}
