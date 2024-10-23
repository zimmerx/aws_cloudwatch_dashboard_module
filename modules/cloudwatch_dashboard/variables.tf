variable "dashboard_name" {
  description = "The name of the CloudWatch dashboard."
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the resources are located."
  type        = string
  default     = "us-east-1" # Default region
}

variable "ec2_instance_ids" {
  description = "List of EC2 instance IDs for monitoring."
  type        = list(string)
  default     = [] # Default to an empty list to make it optional
}

variable "ecs_services" {
  description = "List of ECS services for monitoring. Each service should be a map with 'cluster_name' and 'service_name'."
  type = list(object({
    cluster_name = string
    service_name = string
  }))
  default = [] # Default to an empty list to make it optional
}

variable "s3_bucket_names" {
  description = "List of S3 bucket names for monitoring."
  type        = list(string)
  default     = [] # Default to an empty list to make it optional
}

variable "rds_instance_ids" {
  description = "List of RDS instance identifiers for monitoring."
  type        = list(string)
  default     = [] # Default to an empty list to make it optional
}
