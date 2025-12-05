
data "aws_db_snapshot" "memos_db_snapshot" {
  db_snapshot_identifier = var.db_snapshot_id
}


resource "aws_db_instance" "db" {
  identifier           = var.db_identifier
  instance_class       = var.db_instance_class
  snapshot_identifier  = data.aws_db_snapshot.memos_db_snapshot.id
  db_subnet_group_name = aws_db_subnet_group.private_subnet_group.name
  vpc_security_group_ids = [ aws_security_group.rds-sg.id ]
  storage_encrypted = true
}

resource "aws_db_subnet_group" "private_subnet_group" {
  name = "private_subnet_group"
  description = "Group of private subnets in ${var.vpc_id}"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Allows task to access db"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = [ var.my_ip ]
  }

  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    security_groups = [ var.ecs_sg_id ]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
  }

}