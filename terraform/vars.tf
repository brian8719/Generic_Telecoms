variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}

variable "AMI" {
  type = map(string)
  default = {
    eu-west-1 = "ami-0bb3fad3c0286ebd5"
    eu-west-2 = "ami-0a669382ea0feb73a"
  }
}

variable "INSTANCE_NAME" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  
  validation {
    condition     = length(var.INSTANCE_NAME) > 5
    error_message = "Please enter a a valid INSTANCE_NAME in the format lnxstgdb101."
  }
}

variable "ENV" {
  description = "Environment; Test (tst), Staging (stg) or Production (prd)"
  type        = string
  default     = "tst"
}

variable "APP_TYPE" {
  description = "Web application (wa) or Database (db)"
  type        = string
  default     = "wa"
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

variable "COUNT" {
  default = "1"
}
