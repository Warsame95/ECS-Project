output "ecs_sg_id" {
  value = aws_security_group.ecs-sg.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.task.arn
}