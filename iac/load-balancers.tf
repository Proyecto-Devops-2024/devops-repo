########## LOAD BALANCER DEV PAYMENTS ##########
resource "aws_lb" "dev_payments_lb" {
  name               = "dev-payments-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["dev"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["dev"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["dev"].id
  ]

  tags = {
    Name = "dev-payments-lb"
  }
}

resource "aws_lb_target_group" "dev_payments_tg" {
  name     = "dev-payments-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["dev"].id
  target_type = "ip"
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "dev-payments-tg"
  }
}

resource "aws_lb_listener" "dev_payments_listener" {
  load_balancer_arn = aws_lb.dev_payments_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_payments_tg.arn
  }
}


########## LOAD BALANCER DEV PRODUCTS ##########
resource "aws_lb" "dev_products_lb" {
  name               = "dev-products-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["dev"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["dev"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["dev"].id
  ]

  tags = {
    Name = "dev-products-lb"
  }
}

resource "aws_lb_target_group" "dev_products_tg" {
  name     = "dev-products-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["dev"].id
  target_type = "ip"
  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "dev-products-tg"
  }
}

resource "aws_lb_listener" "dev_products_listener" {
  load_balancer_arn = aws_lb.dev_products_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_products_tg.arn
  }
}
