data "google_service_account_access_token" "default" {
 provider               	= google.impersonation
 target_service_account 	= local.elastic_service_account
 scopes                 	= ["userinfo-email", "cloud-platform"]
 lifetime               	= "1200s"
}