provider "aws" {
  region = "ca-central-1" # Adjust to your AWS region
}

module "cloudwatch_dashboard" {
  source         = ".//modules/cloudwatch_dashboard"
  dashboard_name = "GFL_Dashboard"
  aws_region     = "ca-central-1" # Pass the region

  #EC2 instances ID
  ec2_instance_ids = ["i-04eb4680746fbadd7", "i-03e0e8f946d8128df"] # to skip the service leave it empty 
  # Example ec2_instance_ids  = ["i-0123456789abcdef0", "i-0987654321abcdef0"]

  # ECS services and cluster names
  ecs_services = [] # to skip the service leave it empty 
  # Example for ecs_services: 
  # ecs_services = [
  #  { cluster_name = "my-ecs-cluster", service_name = "my-ecs-service1" },
  # { cluster_name = "my-ecs-cluster", service_name = "my-ecs-service2" }
  # ]

  # S3 buckets
  s3_bucket_names = ["upload-win-dt-flow"] # to skip the service leave it empty 
  # Example  s3_bucket_names = ["my-s3-bucket1", "my-s3-bucket2"]


  # RDS instances
  rds_instance_ids = ["my-rds-instance1"] # to skip the service leave it empty 
  # Example rds_instance_ids = ["my-rds-instance1", "my-rds-instance2"]
}
