########################################################
# UAT Glue Infrastructure Deployment (Sandbox)
########################################################

module "glue_role" {
  source    = "git::https://github.com/mostafasookar/APPS.git//APP-modules/glue-module/glue-role?ref=main"
  role_name = "GlueServiceRole-UAT"
  # default tags are provided by module and output back as glue_role_tags
}

module "glue_manager" {
  source         = "git::https://github.com/mostafasookar/APPS.git//APP-modules/glue-module/glue-manager?ref=main"
  jobs           = local.jobs
  scripts_root   = "${path.module}/../../scripts"
  scripts_bucket = var.scripts_bucket
  role_arn       = module.glue_role.glue_role_arn
  tags           = module.glue_role.glue_role_tags
}

module "glue_trigger" {
  source              = "git::https://github.com/mostafasookar/APPS.git//APP-modules/glue-module/glue-trigger?ref=main"
  jobs                = local.jobs
  dependency_modules  = [module.glue_manager]
  tags                = module.glue_role.glue_role_tags
}

