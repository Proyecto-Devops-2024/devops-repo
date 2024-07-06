resource "aws_ecs_service" "dev_payments_service" {
  name            = "dev-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["dev"].name
  task_definition = aws_ecs_task_definition.payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["dev"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["dev"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS DEV ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.payments_definition]
}

resource "aws_ecs_service" "test_payments_service" {
  name            = "test-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["test"].name
  task_definition = aws_ecs_task_definition.payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["test"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["test"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS TEST ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.payments_definition]
}

resource "aws_ecs_service" "prod_payments_service" {
  name            = "prod-payments-service"
  cluster         = aws_ecs_cluster.ecs_cluster["prod"].name
  task_definition = aws_ecs_task_definition.payments_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = [aws_subnet.vpc-ecs-public-subnet["prod"].id]
    security_groups  = [aws_security_group.ecs-contenedores-sg["prod"].id]
    assign_public_ip = true
  }
  tags = {
    Environment = "PAYMENTS PROD ECS SERVICE"
  }
  depends_on = [aws_ecs_task_definition.payments_definition]
}

