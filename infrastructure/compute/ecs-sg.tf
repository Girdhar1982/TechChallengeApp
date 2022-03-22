
resource "aws_security_group" "ecs_security_group" {
  
  name   = "${var.tag_prefix}-ecs-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "allow tcp Everthing from loadbalancer"
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    security_groups  = [var.loadbalancer_securitygroup_id] 
    cidr_blocks      = []
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    self             = false
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    self        = false
  }

  tags = {
    Name = "${var.tag_prefix}-security-group"
  }

}
