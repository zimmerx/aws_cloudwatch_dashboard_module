resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = flatten([
      # Header widget
      [
        {
          "height" : 6,
          "width" : 24,
          "y" : 0,
          "x" : 0,
          "type" : "text",
          "properties" : {
            "markdown" : "![alt text png image](https://upload.wikimedia.org/wikipedia/en/a/a8/GFL_Environmental_logo.png) \n# Dynamic Dashboard \n## Dynamic dashboard for cloudwatch metrics and logs\n"
          }
        }
      ],

      # EC2 Widgets Section
      length(var.ec2_instance_ids) > 0 ? [
        # EC2 section header
        {
          "height" : 1,
          "width" : 24,
          "y" : 7,
          "x" : 0,
          "type" : "text",
          "properties" : {
            "markdown" : "# EC2 Instances Metrics"
          }
        }
      ] : [],

      length(var.ec2_instance_ids) > 0 ? flatten([
        for ec2_id in var.ec2_instance_ids : [
          {
            "type" : "metric",
            "x" : 0,
            "y" : 8 + index(var.ec2_instance_ids, ec2_id) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/EC2", "CPUUtilization", "InstanceId", ec2_id]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Average",
              "title" : "EC2 CPU Utilization - ${ec2_id}"
            }
          },
          {
            "type" : "metric",
            "x" : 6,
            "y" : 8 + index(var.ec2_instance_ids, ec2_id) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/EC2", "NetworkIn", "InstanceId", ec2_id],
                ["AWS/EC2", "NetworkOut", "InstanceId", ec2_id]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Sum",
              "title" : "EC2 Network In/Out - ${ec2_id}"
            }
          }
        ]
      ]) : [],

      # ECS Widgets Section
      length(var.ecs_services) > 0 ? [
        # ECS section header
        {
          "height" : 1,
          "width" : 24,
          "y" : 7 + length(var.ec2_instance_ids) * 6,
          "x" : 0,
          "type" : "text",
          "properties" : {
            "markdown" : "# ECS Services Metrics"
          }
        }
      ] : [],

      length(var.ecs_services) > 0 ? flatten([
        for ecs_service in var.ecs_services : [
          {
            "type" : "metric",
            "x" : 0,
            "y" : 8 + length(var.ec2_instance_ids) * 6 + index(var.ecs_services, ecs_service) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/ECS", "CPUUtilization", "ClusterName", ecs_service["cluster_name"], "ServiceName", ecs_service["service_name"]]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Average",
              "title" : "ECS CPU Utilization - ${ecs_service["service_name"]}"
            }
          },
          {
            "type" : "metric",
            "x" : 6,
            "y" : 8 + length(var.ec2_instance_ids) * 6 + index(var.ecs_services, ecs_service) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/ECS", "MemoryUtilization", "ClusterName", ecs_service["cluster_name"], "ServiceName", ecs_service["service_name"]]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Average",
              "title" : "ECS Memory Utilization - ${ecs_service["service_name"]}"
            }
          }
        ]
      ]) : [],

      # S3 Widgets Section
      length(var.s3_bucket_names) > 0 ? [
        # S3 section header
        {
          "height" : 1,
          "width" : 24,
          "y" : 7 + (length(var.ec2_instance_ids) + length(var.ecs_services)) * 6,
          "x" : 0,
          "type" : "text",
          "properties" : {
            "markdown" : "# S3 Buckets Metrics"
          }
        }
      ] : [],

      length(var.s3_bucket_names) > 0 ? flatten([
        for s3_bucket in var.s3_bucket_names : [
          {
            "type" : "metric",
            "x" : 0,
            "y" : 8 + (length(var.ec2_instance_ids) + length(var.ecs_services)) * 6 + index(var.s3_bucket_names, s3_bucket) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/S3", "BucketSizeBytes", "BucketName", s3_bucket, "StorageType", "StandardStorage"]
              ],
              "region" : var.aws_region,
              "period" : 86400,
              "stat" : "Average",
              "title" : "S3 Bucket Size - ${s3_bucket}"
            }
          },
          {
            "type" : "metric",
            "x" : 6,
            "y" : 8 + (length(var.ec2_instance_ids) + length(var.ecs_services)) * 6 + index(var.s3_bucket_names, s3_bucket) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/S3", "NumberOfObjects", "BucketName", s3_bucket, "StorageType", "AllStorageTypes"]
              ],
              "region" : var.aws_region,
              "period" : 86400,
              "stat" : "Average",
              "title" : "S3 Number of Objects - ${s3_bucket}"
            }
          }
        ]
      ]) : [],

      # RDS Widgets Section
      length(var.rds_instance_ids) > 0 ? [
        # RDS section header
        {
          "height" : 1,
          "width" : 24,
          "y" : 7 + (length(var.ec2_instance_ids) + length(var.ecs_services) + length(var.s3_bucket_names)) * 6,
          "x" : 0,
          "type" : "text",
          "properties" : {
            "markdown" : "# RDS Instances Metrics"
          }
        }
      ] : [],

      length(var.rds_instance_ids) > 0 ? flatten([
        for rds_id in var.rds_instance_ids : [
          {
            "type" : "metric",
            "x" : 0,
            "y" : 8 + (length(var.ec2_instance_ids) + length(var.ecs_services) + length(var.s3_bucket_names)) * 6 + index(var.rds_instance_ids, rds_id) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", rds_id]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Average",
              "title" : "RDS CPU Utilization - ${rds_id}"
            }
          },
          {
            "type" : "metric",
            "x" : 6,
            "y" : 8 + (length(var.ec2_instance_ids) + length(var.ecs_services) + length(var.s3_bucket_names)) * 6 + index(var.rds_instance_ids, rds_id) * 6,
            "width" : 6,
            "height" : 6,
            "properties" : {
              "metrics" : [
                ["AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", rds_id]
              ],
              "region" : var.aws_region,
              "period" : 300,
              "stat" : "Average",
              "title" : "RDS Free Storage Space - ${rds_id}"
            }
          }
        ]
      ]) : []
    ])
  })
}
