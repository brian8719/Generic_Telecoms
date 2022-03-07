variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}

variable "AMI" {
  type = map(string)
  default = {
    eu-west-1 = "ami-0bb3fad3c0286ebd5"
    eu-west-2 = "ami-0a669382ea0feb73a"
  }
}

variable "REGION" {
  default = "eu-west-1"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "KEY_NAME" {
  default = "Generic_Telecoms"
}

