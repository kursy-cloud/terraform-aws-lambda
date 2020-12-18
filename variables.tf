variable "name" {
  description = "Base name for lambda and related resources"
}
variable "policy" {}
variable "source_dir" {}
variable "handler" {
  default = "index.handler"
}
variable "runtime" {
  default = "nodejs12.x"
}

