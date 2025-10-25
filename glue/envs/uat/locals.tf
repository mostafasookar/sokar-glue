locals {
  jobs = [
    for job in yamldecode(file("${path.module}/../../jobs.yaml")) : merge(
      job,
      {
        # Always add default tmp & logs for the current env/bucket
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
