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