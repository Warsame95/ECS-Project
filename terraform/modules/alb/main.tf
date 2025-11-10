// ALB resource block to be added

// Then add target group association resource

resource "aws_lb_target_group" "memos-service-tg" {
  name     = "memos-service-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  ip_address_type = "ipv4"
  target_type = "ip"
  

  health_check {
    enabled = true
    healthy_threshold = 5
    interval = 30
    matcher = "200"
    path = "/health"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
    unhealthy_threshold = 2
  }

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count = "1"
      minimum_healthy_targets_percentage = "off"
    }

    unhealthy_state_routing {
      minimum_healthy_targets_count = 1
      minimum_healthy_targets_percentage = "off"
    }

  }

  stickiness {
    type = "lb_cookie"
    enabled = true
    cookie_duration = 86400
  }


}




resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allows https traffic into ecs"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

}