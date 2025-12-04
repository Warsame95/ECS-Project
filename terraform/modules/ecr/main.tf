resource aws_ecr_repository "memos_repo" {
    name = var.repo_name
    image_tag_mutability = "MUTABLE"

    encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

}

data "aws_ssm_parameter" "container_image" {
  name = "/ecs-project/container-image"
}