resource "aws_ecs_cluster" "memos-cluster" {
    name = "memos-cluster"

    configuration {
          execute_command_configuration {
            logging    = "DEFAULT"
        }
    }
}

resource "aws_security_group" "ecs-sg" {
  name        = "ecs-sg"
  description = "Allows traffic coming from alb"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 8081
    protocol = "tcp"
    to_port = 8081

    security_groups = [ "sg-0184077de618dca88" ]
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

// task definition resource to be added

// service resource to be added 