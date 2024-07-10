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
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
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

########## LOAD BALANCER TEST PAYMENTS ##########
resource "aws_lb" "test_payments_lb" {
  name               = "test-payments-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["test"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["test"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["test"].id
  ]

  tags = {
    Name = "test-payments-lb"
  }
}

resource "aws_lb_target_group" "test_payments_tg" {
  name     = "test-payments-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["test"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "test-payments-tg"
  }
}

resource "aws_lb_listener" "test_payments_listener" {
  load_balancer_arn = aws_lb.test_payments_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_payments_tg.arn
  }
}


########## LOAD BALANCER PROD PAYMENTS ##########
resource "aws_lb" "prod_payments_lb" {
  name               = "prod-payments-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["prod"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["prod"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["prod"].id
  ]

  tags = {
    Name = "prod-payments-lb"
  }
}

resource "aws_lb_target_group" "prod_payments_tg" {
  name     = "prod-payments-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["prod"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "prod-payments-tg"
  }
}

resource "aws_lb_listener" "prod_payments_listener" {
  load_balancer_arn = aws_lb.prod_payments_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_payments_tg.arn
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
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
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

########## LOAD BALANCER TEST PRODUCTS ##########
resource "aws_lb" "test_products_lb" {
  name               = "test-products-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["test"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["test"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["test"].id
  ]

  tags = {
    Name = "test-products-lb"
  }
}

resource "aws_lb_target_group" "test_products_tg" {
  name     = "test-products-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["test"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "test-products-tg"
  }
}

resource "aws_lb_listener" "test_products_listener" {
  load_balancer_arn = aws_lb.test_products_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_products_tg.arn
  }
}

########## LOAD BALANCER PROD PRODUCTS ##########
resource "aws_lb" "prod_products_lb" {
  name               = "prod-products-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["prod"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["prod"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["prod"].id
  ]

  tags = {
    Name = "prod-products-lb"
  }
}

resource "aws_lb_target_group" "prod_products_tg" {
  name     = "prod-products-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["prod"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "prod-products-tg"
  }
}

resource "aws_lb_listener" "prod_products_listener" {
  load_balancer_arn = aws_lb.prod_products_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_products_tg.arn
  }
}

########## LOAD BALANCER DEV SHIPPING ##########
resource "aws_lb" "dev_shipping_lb" {
  name               = "dev-shipping-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["dev"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["dev"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["dev"].id
  ]

  tags = {
    Name = "dev-shipping-lb"
  }
}

resource "aws_lb_target_group" "dev_shipping_tg" {
  name     = "dev-shipping-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["dev"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "dev-shipping-tg"
  }
}

resource "aws_lb_listener" "dev_shipping_listener" {
  load_balancer_arn = aws_lb.dev_shipping_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_shipping_tg.arn
  }
}

########## LOAD BALANCER TEST SHIPPING ##########
resource "aws_lb" "test_shipping_lb" {
  name               = "test-shipping-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["test"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["test"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["test"].id
  ]

  tags = {
    Name = "test-shipping-lb"
  }
}

resource "aws_lb_target_group" "test_shipping_tg" {
  name     = "test-shipping-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["test"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "test-shipping-tg"
  }
}

resource "aws_lb_listener" "test_shipping_listener" {
  load_balancer_arn = aws_lb.test_shipping_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_shipping_tg.arn
  }
}

########## LOAD BALANCER PROD SHIPPING ##########
resource "aws_lb" "prod_shipping_lb" {
  name               = "prod-shipping-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["prod"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["prod"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["prod"].id
  ]

  tags = {
    Name = "prod-shipping-lb"
  }
}

resource "aws_lb_target_group" "prod_shipping_tg" {
  name     = "prod-shipping-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["prod"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "prod-shipping-tg"
  }
}

resource "aws_lb_listener" "prod_shipping_listener" {
  load_balancer_arn = aws_lb.prod_shipping_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_shipping_tg.arn
  }
}

########## LOAD BALANCER DEV ORDERS ##########
resource "aws_lb" "dev_orders_lb" {
  name               = "dev-orders-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["dev"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["dev"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["dev"].id
  ]

  tags = {
    Name = "dev-orders-lb"
  }
}

resource "aws_lb_target_group" "dev_orders_tg" {
  name     = "dev-orders-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["dev"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "dev-orders-tg"
  }
}

resource "aws_lb_listener" "dev_orders_listener" {
  load_balancer_arn = aws_lb.dev_orders_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev_orders_tg.arn
  }
}

########## LOAD BALANCER TEST ORDERS ##########
resource "aws_lb" "test_orders_lb" {
  name               = "test-orders-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["test"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["test"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["test"].id
  ]

  tags = {
    Name = "test-orders-lb"
  }
}

resource "aws_lb_target_group" "test_orders_tg" {
  name     = "test-orders-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["test"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "test-orders-tg"
  }
}

resource "aws_lb_listener" "test_orders_listener" {
  load_balancer_arn = aws_lb.test_orders_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_orders_tg.arn
  }
}

########## LOAD BALANCER PROD ORDERS ##########
resource "aws_lb" "prod_orders_lb" {
  name               = "prod-orders-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs-load-balancers-sg["prod"].id]
  subnets            = [
    aws_subnet.vpc-ecs-public-subnet["prod"].id,
    aws_subnet.vpc-ecs-public-subnet-secundary["prod"].id
  ]

  tags = {
    Name = "prod-orders-lb"
  }
}

resource "aws_lb_target_group" "prod_orders_tg" {
  name     = "prod-orders-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc-ecs["prod"].id
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "300"
    protocol            = "HTTP"
    matcher             = "200,404"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "prod-orders-tg"
  }
}

resource "aws_lb_listener" "prod_orders_listener" {
  load_balancer_arn = aws_lb.prod_orders_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_orders_tg.arn
  }
}
