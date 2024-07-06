resource "aws_ecs_task_definition" "products_definition" {

  family                   = "products-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = "arn:aws:iam::931481537897:role/LabRole"
  execution_role_arn       = "arn:aws:iam::931481537897:role/LabRole"

  container_definitions = jsonencode([{
    name      = "products-container"
    image     = "931481537897.dkr.ecr.us-east-1.amazonaws.com/products-service-ecr-repo:latest"
    cpu       = 0
    essential = true

    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      appProtocol   = "http"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/products-task-definition"
        awslogs-create-group  = "true"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  tags = {
    Name = "products-task-definition"
  }
}

resource "aws_ecs_task_definition" "shipping_definition" {

  family                   = "shipping-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = "arn:aws:iam::931481537897:role/LabRole"
  execution_role_arn       = "arn:aws:iam::931481537897:role/LabRole"

  container_definitions = jsonencode([{
    name      = "shipping-container"
    image     = "931481537897.dkr.ecr.us-east-1.amazonaws.com/shipping-service-ecr-repo:latest"
    cpu       = 0
    essential = true

    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      appProtocol   = "http"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/shipping-task-definition"
        awslogs-create-group  = "true"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  tags = {
    Name = "shipping-task-definition"
  }
}

resource "aws_ecs_task_definition" "payments_definition" {

  family                   = "payments-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = "arn:aws:iam::931481537897:role/LabRole"
  execution_role_arn       = "arn:aws:iam::931481537897:role/LabRole"

  container_definitions = jsonencode([{
    name      = "payments-container"
    image     = "931481537897.dkr.ecr.us-east-1.amazonaws.com/payments-service-ecr-repo:latest"
    cpu       = 0
    essential = true

    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      appProtocol   = "http"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/payments-task-definition"
        awslogs-create-group  = "true"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  tags = {
    Name = "payments-task-definition"
  }
}

resource "aws_ecs_task_definition" "orders_definition" {
  family                   = "orders-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = "arn:aws:iam::931481537897:role/LabRole"
  execution_role_arn       = "arn:aws:iam::931481537897:role/LabRole"

  container_definitions = jsonencode([{
    name      = "orders-container"
    image     = "931481537897.dkr.ecr.us-east-1.amazonaws.com/orders-service-ecr-repo:latest"
    cpu       = 0
    essential = true

    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
      appProtocol   = "http"
    }]

    environment = [{
      name  = "APP_ARGS"
      value = "dev-payments-lb-1350613012.us-east-1.elb.amazonaws.com dev-shipping-lb-1454690909.us-east-1.elb.amazonaws.com dev-products-lb-1057831227.us-east-1.elb.amazonaws.com"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/orders-task-definition"
        awslogs-create-group  = "true"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}


