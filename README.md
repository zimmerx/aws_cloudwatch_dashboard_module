# AWS CloudWatch Dashboard Module

This Terraform module creates a customizable AWS CloudWatch dashboard to monitor different AWS services, including EC2 instances, ECS services, S3 buckets, and RDS instances.

## Requirements

- Terraform 0.12 or later
- AWS account with permissions to create CloudWatch dashboards and monitor EC2, ECS, S3, and RDS services.
- An AWS IAM user with necessary permissions.

## Configuration

### Provider Configuration

The module uses the `aws` provider, and the region should be specified in the provider configuration:

```hcl
provider "aws" {
  region = "ca-central-1" # Adjust to your AWS region
}
```
Module Configuration
You can configure the CloudWatch dashboard by adjusting the variables in the module block. Below are the configurable parameters:

dashboard_name (Required)
Type: string
Description: The name of the CloudWatch dashboard. Example: GFL_Dashboard.
aws_region (Required)
Type: string
Description: The AWS region where the CloudWatch dashboard will be created. Example: ca-central-1.
ec2_instance_ids (Optional)
Type: list(string)
Description: List of EC2 instance IDs to monitor. Leave empty to skip monitoring EC2 instances.

Example:
```
ec2_instance_ids = ["i-04eb4680746fbadd7", "i-03e0e8f946d8128df"]
ecs_services (Optional)
Type: list(object)
Description: List of ECS services to monitor. Each entry must include the cluster_name and service_name. Leave empty to skip monitoring ECS services.
```
Example:
```
ecs_services = [
  { cluster_name = "my-ecs-cluster", service_name = "my-ecs-service1" },
  { cluster_name = "my-ecs-cluster", service_name = "my-ecs-service2" }
]
s3_bucket_names (Optional)
Type: list(string)
Description: List of S3 buckets to monitor. Leave empty to skip monitoring S3 buckets.
```
Example:
```
s3_bucket_names = ["upload-win-dt-flow"]
rds_instance_ids (Optional)
Type: list(string)
Description: List of RDS instance IDs to monitor. Leave empty to skip monitoring RDS instances.
```
Example:
```
rds_instance_ids = ["my-rds-instance1"]
```
Example Usage
```
provider "aws" {
  region = "ca-central-1" # Adjust to your AWS region
}
```
```
module "cloudwatch_dashboard" {
  source         = ".//modules/cloudwatch_dashboard"
  dashboard_name = "GFL_Dashboard"
  aws_region     = "ca-central-1" # Pass the region

  ec2_instance_ids = ["i-04eb4680746fbadd7", "i-03e0e8f946d8128df"]

  ecs_services = []

  s3_bucket_names = ["upload-win-dt-flow"]

  rds_instance_ids = ["my-rds-instance1"]
}
```
How to Use
Clone the repository to your local machine.
Navigate to the directory containing the Terraform code.
Initialize the Terraform configuration:
Copy code
```terraform init```
Plan the infrastructure:
```terraform plan```
Apply the configuration to create the CloudWatch dashboard:
```terraform apply```
