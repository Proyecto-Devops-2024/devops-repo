########### PAYMENTS SERVICE ##########

resource "aws_ecs_service" "dev_payments_service" {
  name            = "dev-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["dev"].name
  task_definition = aws_ecs_task_definition.dev_payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.dev_payments_tg.arn
    container_name   = "payments-container"  
    container_port   = 8080  
  }

  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["dev"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["dev"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS DEV ECS SERVICE"
  }
  depends_on = [
    aws_ecs_task_definition.dev_payments_definition,
    aws_lb.dev_payments_lb,
    aws_lb_target_group.dev_payments_tg,
    aws_lb_listener.dev_payments_listener
  ]
}

resource "aws_ecs_service" "test_payments_service" {
  name            = "test-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["test"].name
  task_definition = aws_ecs_task_definition.test_payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.test_payments_tg.arn
    container_name   = "payments-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["test"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["test"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS TEST ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.test_payments_definition]
}

resource "aws_ecs_service" "prod_payments_service" {
  name            = "prod-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["prod"].name
  task_definition = aws_ecs_task_definition.prod_payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.prod_payments_tg.arn
    container_name   = "payments-container"  
    container_port   = 8080  
  }
  
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["prod"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["prod"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS PROD ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.prod_payments_definition]
}


########### PRODUCTS SERVICE ##########

resource "aws_ecs_service" "dev_products_service" {
  name            = "dev-products-service"
  cluster         = aws_ecs_cluster.ecs_cluster["dev"].name
  task_definition = aws_ecs_task_definition.dev_products_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.dev_products_tg.arn
    container_name   = "products-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["dev"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["dev"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PRODUCTS DEV ECS SERVICE"
  }
  depends_on = [
    aws_ecs_task_definition.dev_payments_definition,
    aws_lb.dev_payments_lb,
    aws_lb_target_group.dev_payments_tg,
    aws_lb_listener.dev_payments_listener
  ]
}

resource "aws_ecs_service" "test_products_service" {
  name            = "test-products-service"
  cluster         = aws_ecs_cluster.ecs_cluster["test"].name
  task_definition = aws_ecs_task_definition.test_products_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.test_products_tg.arn
    container_name   = "products-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["test"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["test"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PRODUCTS TEST ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.test_products_definition]
}

resource "aws_ecs_service" "prod_products_service" {
  name            = "prod-products-service"
  cluster         = aws_ecs_cluster.ecs_cluster["prod"].name
  task_definition = aws_ecs_task_definition.prod_products_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.prod_products_tg.arn
    container_name   = "products-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["prod"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["prod"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PRODUCTS PROD ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.prod_products_definition]
}

########### SHIPPING SERVICE ##########

resource "aws_ecs_service" "dev_shipping_service" {
  name            = "dev-shipping-service"
  cluster         = aws_ecs_cluster.ecs_cluster["dev"].name
  task_definition = aws_ecs_task_definition.dev_shipping_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.dev_shipping_tg.arn
    container_name   = "shipping-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["dev"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["dev"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "SHIPPING DEV ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.dev_shipping_definition]
}

resource "aws_ecs_service" "test_shipping_service" {
  name            = "test-shipping-service"
  cluster         = aws_ecs_cluster.ecs_cluster["test"].name
  task_definition = aws_ecs_task_definition.test_shipping_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.test_shipping_tg.arn
    container_name   = "shipping-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["test"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["test"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "SHIPPING TEST ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.test_shipping_definition]
}

resource "aws_ecs_service" "prod_shipping_service" {
  name            = "prod-shipping-service"
  cluster         = aws_ecs_cluster.ecs_cluster["prod"].name
  task_definition = aws_ecs_task_definition.prod_shipping_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.prod_shipping_tg.arn
    container_name   = "shipping-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["prod"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["prod"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "SHIPPING PROD ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.prod_shipping_definition]
}

########### ORDERS SERVICE ##########

resource "aws_ecs_service" "dev_orders_service" {
  name            = "dev-orders-service"
  cluster         = aws_ecs_cluster.ecs_cluster["dev"].name
  task_definition = aws_ecs_task_definition.dev_orders_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.dev_orders_tg.arn
    container_name   = "orders-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["dev"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["dev"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "ORDERS DEV ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.dev_orders_definition]
}

resource "aws_ecs_service" "test_orders_service" {
  name            = "test-orders-service"
  cluster         = aws_ecs_cluster.ecs_cluster["test"].name
  task_definition = aws_ecs_task_definition.test_orders_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.test_orders_tg.arn
    container_name   = "orders-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["test"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["test"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "ORDERS TEST ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.test_orders_definition]
}

resource "aws_ecs_service" "prod_orders_service" {
  name            = "prod-orders-service"
  cluster         = aws_ecs_cluster.ecs_cluster["prod"].name
  task_definition = aws_ecs_task_definition.prod_orders_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = aws_lb_target_group.prod_orders_tg.arn
    container_name   = "orders-container"  
    container_port   = 8080  
  }
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["prod"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["prod"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "ORDERS PROD ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.prod_orders_definition]
}
