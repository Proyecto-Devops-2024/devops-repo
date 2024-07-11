# TASK DEFINITION PRODUCTS #

resource "aws_ecs_task_definition" "dev_products_definition" {
  family                   = "dev-products-task-definition"
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
        awslogs-group         = "/ecs/dev-products-task-definition"
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
    Name = "dev-products-task-definition"
  }
}

resource "aws_ecs_task_definition" "test_products_definition" {
  family                   = "test-products-task-definition"
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
        awslogs-group         = "/ecs/test-products-task-definition"
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
    Name = "test-products-task-definition"
  }
}

resource "aws_ecs_task_definition" "prod_products_definition" {
  family                   = "prod-products-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
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
        awslogs-group         = "/ecs/prod-products-task-definition"
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
    Name = "prod-products-task-definition"
  }
}

# TASK DEFINITION ORDERS #


resource "aws_ecs_task_definition" "dev_orders_definition" {
  family                   = "dev-orders-task-definition"
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
      value = "${aws_lb.dev_payments_lb.dns_name} ${aws_lb.dev_shipping_lb.dns_name} ${aws_lb.dev_products_lb.dns_name}"	
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/dev-orders-task-definition"
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
    Name = "dev-orders-task-definition"
  }
}

resource "aws_ecs_task_definition" "test_orders_definition" {
  family                   = "test-orders-task-definition"
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
      value = "${aws_lb.test_payments_lb.dns_name} ${aws_lb.test_shipping_lb.dns_name} ${aws_lb.test_products_lb.dns_name}"	
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/test-orders-task-definition"
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
    Name = "test-orders-task-definition"
  }
}

resource "aws_ecs_task_definition" "prod_orders_definition" {
  family                   = "prod-orders-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
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
      value = "http://${aws_lb.prod_payments_lb.dns_name} http://${aws_lb.prod_shipping_lb.dns_name} http://${aws_lb.prod_products_lb.dns_name}"	
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/prod-orders-task-definition"
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
    Name = "prod-orders-task-definition"
  }
}



### SHIPPING TASK DEFINITION

resource "aws_ecs_task_definition" "dev_shipping_definition" {
  family                   = "dev-shipping-task-definition"
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
        awslogs-group         = "/ecs/dev-shipping-task-definition"
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
    Name = "dev-shipping-task-definition"
  }
}

resource "aws_ecs_task_definition" "test_shipping_definition" {
  family                   = "test-shipping-task-definition"
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
        awslogs-group         = "/ecs/test-shipping-task-definition"
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
    Name = "test-shipping-task-definition"
  }
}

resource "aws_ecs_task_definition" "prod_shipping_definition" {
  family                   = "prod-shipping-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
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
        awslogs-group         = "/ecs/prod-shipping-task-definition"
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
    Name = "prod-shipping-task-definition"
  }
}

### PAYMENTS TASK DEFINITION

resource "aws_ecs_task_definition" "dev_payments_definition" {
  family                   = "dev-payments-task-definition"
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
        awslogs-group         = "/ecs/dev-payments-task-definition"
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
    Name = "dev-payments-task-definition"
  }
}

resource "aws_ecs_task_definition" "test_payments_definition" {
  family                   = "test-payments-task-definition"
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
        awslogs-group         = "/ecs/test-payments-task-definition"
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
    Name = "test-payments-task-definition"
  }
}

resource "aws_ecs_task_definition" "prod_payments_definition" {
  family                   = "prod-payments-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
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
        awslogs-group         = "/ecs/prod-payments-task-definition"
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
    Name = "prod-payments-task-definition"
  }
}
