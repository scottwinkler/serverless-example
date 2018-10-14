resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = "${var.project_name}-${var.environment}-aurora-cluster"
  engine                  = "aurora"
  availability_zones      = ["${var.region}a", "${var.region}b", "${var.region}c"]
  database_name           = "example"
  master_username         = "${var.rds_user}"
  master_password         = "${var.rds_password}"
  backup_retention_period = 1
  skip_final_snapshot = true
  preferred_backup_window = "04:00-07:00"
  engine_mode = "serverless"
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 2
    seconds_until_auto_pause = 300
  }
}