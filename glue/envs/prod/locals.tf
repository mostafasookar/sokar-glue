locals {
  # Parse YAML jobs
  raw_jobs = yamldecode(file("${path.module}/../../jobs.yaml"))

  # Normalize each job
  jobs = [
    for job in local.raw_jobs : {
      name              = job.name
      description       = try(job.description, "")
      script_file       = try(job.script_file, "")
      glue_version      = try(job.glue_version, "5.0")
      python_version    = try(job.python_version, "3")
      command_name      = try(job.command_name, "glueetl")
      worker_type       = try(job.worker_type, "G.1X")
      number_of_workers = try(job.number_of_workers, 2)
      connections       = try(job.connections, [])
      default_arguments = merge(
        {
          "--TempDir"               = "s3://${var.scripts_bucket}/temporary/"
          "--spark-event-logs-path" = "s3://${var.scripts_bucket}/sparkHistoryLogs/"
        },
        try(job.default_arguments, {})
      )
      tags = try(job.tags, {})
      trigger = {
        enabled  = try(job.trigger.enabled, false)
        type     = try(job.trigger.type, "")
        schedule = try(job.trigger.schedule, "")
      }
    }
  ]
}
