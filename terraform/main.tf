locals {
  environments = [
                   "tst",
                   "stg",
                   "prd",
                 ]
  app_types    = [
                   "db",
                   "wa",
                 ]
  env_app_types = distinct(flatten([
    for Env in local.environments : [
          for App in local.app_types : {
            Env = Env
                App = App
          }
        ]
  ]))
}

resource "aws_instance" "test_demo" {
  for_each = { for entry in local.env_app_types: "${entry.Env}.${entry.App}" => entry }

  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  tags = {
        Name = "lnx${each.value.Env}${each.value.App}"
        Env = each.value.Env
        App = each.value.App
  }

}
