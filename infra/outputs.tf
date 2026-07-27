output "alb_url" {
  value       = module.alb.alb_dns_name
  description = "DNS name of the load balancer."
}

output "app_url" {
  value       = module.dns.app_url
  description = "The https url of the application."
}
