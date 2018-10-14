output "rds_host" {
    value = "${aws_rds_cluster.rds_cluster.endpoint}"
}

output "rds_port" {
    value = "${aws_rds_cluster.rds_cluster.port}"
}

output "rds_database" {
    value = "${aws_rds_cluster.rds_cluster.database_name}"
}