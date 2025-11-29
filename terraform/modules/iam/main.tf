resource "aws_iam_role" "execution_role" {
    name = var.execution_role_name

    assume_role_policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action = "sts:AssumeRole"
      }
    ]
  })

}

resource "aws_iam_role_policy_attachment" "execution_policy" {
  role = aws_iam_role.execution_role.name
  policy_arn = var.execution_policy_arn
}

resource "aws_iam_policy" "ecs_execution_secrets" {
  name = "${var.execution_role_name}-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "secretsmanager:GetSecretValue",
          "kms:Decrypt"
        ]
        Resource = [
          var.my_secret_arn,
          var.kms_key_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "execution_secrets" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.ecs_execution_secrets.arn
}