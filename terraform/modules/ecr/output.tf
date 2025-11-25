output "repository_uri" {
  value = aws_ecr_repository.memos_repo.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.memos_repo.name
}