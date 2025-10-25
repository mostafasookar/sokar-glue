locals {
  jobs = [
    for job in yamldecode(file("${path.module}/../../jobs.yaml")) : merge(
      job,
      {
        default_arguments = merge(
          {
            "--TempDir"               = "s3://${var.scripts_bucket}/temporary/"
            "--spark-event-logs-path" = "s3://${var.scripts_bucket}/sparkHistoryLogs/"
          },
          lookup(job, "default_arguments", {})
        )
      }
    )
  ]
}
