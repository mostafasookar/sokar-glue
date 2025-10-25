locals {
  _job_defaults = {
    description        = ""
    glue_version       = "5.0"
    python_version     = "3"
    command_name       = "glueetl"
    worker_type        = "G.1X"
    number_of_workers  = 2
    timeout            = 300
    max_retries        = 0
    connections        = []
    default_arguments  = {}
    tags               = {}
    trigger            = { enabled = false }
  }

  jobs = [
    for job in yamldecode(file("${path.module}/../../jobs.yaml")) :
    merge(
      local._job_defaults,
      job,
      {
        default_arguments = merge(
          {
            "--TempDir"               = "s3://${var.scripts_bucket}/temporary/"
            "--spark-event-logs-path" = "s3://${var.scripts_bucket}/sparkHistoryLogs/"
          },
          lookup(job, "default_arguments", {})
        ),
        trigger = merge(
          { enabled = false },
          try(job.trigger, {})
        )
      }
    )
  ]
}
