
variable "ambientes" {
  description = "Lista de entornos"
  type        = map(any)
  default     = {
    dev  = { name = "dev" }
    test = { name = "test" }
    prod = { name = "prod" }
  }
}

# Crear Clusters ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  for_each = var.ambientes

  name = "${each.value.name}-ecs-cluster"

  tags = {
    Name = "${each.value.name}-ecs-cluster"
  }
}

resource "aws_ecs_task_definition" "products_definition" {
  for_each                = var.ambientes
  family                   = "${each.value.name}-products-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = "arn:aws:iam::931481537897:role/LabRole"
  execution_role_arn       = "arn:aws:iam::931481537897:role/LabRole"

  container_definitions = jsonencode([{
    name      = "orders"
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
        awslogs-group         = "/ecs/products-definition"
        awslogs-create-group  = "true"
        awslogs-region        = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
  runtime_platform {
    cpu_architecture       = "X86_64"
    operating_system_family = "LINUX"
  }
  tags = {
    Name = "${each.value.name}-products-definition"
  }
}


