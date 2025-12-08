resource "aws_ecs_cluster" "memos-cluster" {
    name = "${var.name}-cluster"

    configuration {
          execute_command_configuration {
            logging    = "DEFAULT"
        }
    }
}


resource "aws_ecs_task_definition" "task" {
  family = "${var.name}-task"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 512
  network_mode = "awsvpc"
  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name = var.name
      image = data.aws_ssm_parameter.container_image.value
      cpu = 0
      essential = true

      portMappings = [
        {
          containerPort = 8081
          hostPort = 8081
          name = "${var.name}-80-tcp"
          protocol = "tcp"

        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.region
          awslogs-group         = "/ecs/memos-task"
          awslogs-stream-prefix = "ecs"
        }
      }

      environment = [
        {
          name  = "MEMOS_DRIVER"
          value = "mysql"
        }
      ]
      
      secrets = [
        {
          name = "MEMOS_DSN"
          valueFrom = aws_secretsmanager_secret_version.my_secret_version.arn
        }
      ]

    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  lifecycle {
    create_before_destroy = true
  }


}
 

resource "aws_ecs_service" "name" {
  name = var.name
  cluster = aws_ecs_cluster.memos-cluster.arn
  task_definition = aws_ecs_task_definition.task.arn
  launch_type = "FARGATE"

  desired_count = 2

  network_configuration {
    subnets = var.private_subnet_ids
    security_groups = [aws_security_group.ecs-sg.id]
    assign_public_ip = false
  }

  load_balancer {
    container_name = var.name
    container_port = 8081
    target_group_arn = var.target_group_arn
  }
}

resource "aws_secretsmanager_secret" "my_secret" {
  name = "db-credentials"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "my_secret_version" {
  secret_id = aws_secretsmanager_secret.my_secret.id
  secret_string = "${var.db_username}:${var.db_password}@tcp(${var.db_host}:3306)/${var.db_name}"
}

data "aws_kms_key" "secretsmanager_kms" {
  key_id = "arn:aws:kms:eu-west-2:932175181322:key/c444c980-c18c-4c71-bc1a-ae2ee73a5490"
}

data "aws_ssm_parameter" "container_image" {
  name = "/ecs-project/container-image"
}


resource "aws_security_group" "ecs-sg" {
  name        = "ecs-sg"
  description = "Allows traffic coming from alb"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 8081
    protocol = "tcp"
    to_port = 8081 
    security_groups = [ var.alb_sg_id ]
  }

  egress {
    from_port = 2049
    protocol = "tcp"
    to_port = 2049

    security_groups = [ "sg-0b466553c2b137c2e" ]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }
 
}
