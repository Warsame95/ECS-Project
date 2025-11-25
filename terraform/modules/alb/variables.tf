variable "vpc_id" {
  type = string
}

variable "ecs_sg_id" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "acm_certificate_arn" {
  type = string
}