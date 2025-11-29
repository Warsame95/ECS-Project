output "ecs_sg_id" {
  value = aws_security_group.ecs-sg.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.task.arn
}

output "my_secret_arn" {
  value = aws_secretsmanager_secret.my_secret.arn
}

output "kms_key_arn" {
  value = data.aws_kms_key.secretsmanager_kms.arn
}