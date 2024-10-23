module "cloudwatch_dashboard" {
  source         = ".//modules/cloudwatch_dashboard"
  dashboard_name = "GFL_Dashboard"
  aws_region     = "ca-central-1" # Pass the region
}
