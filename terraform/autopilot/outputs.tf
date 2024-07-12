output "endpoint" {
  sensitive = true
  value     = local.endpoint
}

output "cluster_ca_certificate" {
  sensitive   = true
  description = "The cluster_ca_certificate value for use with the kubernetes provider."
  value       = base64decode(local.cluster_ca_certificate)
}

output "host" {
  description = "The host value for use with the kubernetes provider."
  value       = local.host
}

# output "token" {
#   sensitive   = true
#   description = "The token value for use with the kubernetes provider."
#   value       = module.autopilot.data.google_client_config.provider.access_token
# }