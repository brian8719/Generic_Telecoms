resource "aws_instance" var.INSTANCE_NAME {
  ami = lookup(var.AMI, var.REGION)
  instance_type = var.INSTANCE_TYPE
  key_name = var.KEY_NAME
  tags = {
	Name = var.INSTANCE_NAME
	Env = var.ENV
	App = var.APP_TYPE
  }
  count = var.COUNT
}
