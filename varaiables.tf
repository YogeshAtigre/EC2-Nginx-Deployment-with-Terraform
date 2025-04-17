variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "yogeshhvp.pem"
  description = "Key Name and Value"
  type = string
}