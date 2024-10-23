output "dashboard_url" {
  description = "The URL of the CloudWatch dashboard."
  value       = "https://console.aws.amazon.com/cloudwatch/home#dashboards:name=${var.dashboard_name}"
}
