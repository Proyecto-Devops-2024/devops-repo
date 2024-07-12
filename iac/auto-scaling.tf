# AUTO ESCALADO PRODUCCION

# ORDERS SERVICE
resource "aws_appautoscaling_target" "ecs_orders_prod_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster["prod"].name}/${aws_ecs_service.prod_orders_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_orders_prod_policy" {
  name               = "Auto-Scaling-Policy-prod-orders-service"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_orders_prod_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_orders_prod_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_orders_prod_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 10000.0
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${replace(aws_lb.prod_orders_lb.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:loadbalancer/app/", "app/")}/${replace(aws_lb_target_group.prod_orders_tg.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:targetgroup/", "targetgroup/")}"
    }

    scale_in_cooldown  = 30
    scale_out_cooldown = 30
  }
}

# PAYMENTS SERVICE
resource "aws_appautoscaling_target" "ecs_payments_prod_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster["prod"].name}/${aws_ecs_service.prod_payments_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_payments_prod_policy" {
  name               = "Auto-Scaling-Policy-prod-payments-service"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_payments_prod_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_payments_prod_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_payments_prod_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 25000.0
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${replace(aws_lb.prod_payments_lb.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:loadbalancer/app/", "app/")}/${replace(aws_lb_target_group.prod_payments_tg.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:targetgroup/", "targetgroup/")}"
    }

    scale_in_cooldown  = 30
    scale_out_cooldown = 30
  }
}

# SHIPPING SERVICE
resource "aws_appautoscaling_target" "ecs_shipping_prod_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster["prod"].name}/${aws_ecs_service.prod_shipping_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_shipping_prod_policy" {
  name               = "Auto-Scaling-Policy-prod-shipping-service"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_shipping_prod_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_shipping_prod_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_shipping_prod_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 160000.0
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${replace(aws_lb.prod_shipping_lb.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:loadbalancer/app/", "app/")}/${replace(aws_lb_target_group.prod_shipping_tg.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:targetgroup/", "targetgroup/")}"
    }

    scale_in_cooldown  = 30
    scale_out_cooldown = 30
  }
}

# PRODUCTS SERVICE
resource "aws_appautoscaling_target" "ecs_products_prod_target" {
  max_capacity       = 3
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster["prod"].name}/${aws_ecs_service.prod_products_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_products_prod_policy" {
  name               = "Auto-Scaling-Policy-prod-products-service"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_products_prod_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_products_prod_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_products_prod_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 160000.0
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${replace(aws_lb.prod_products_lb.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:loadbalancer/app/", "app/")}/${replace(aws_lb_target_group.prod_products_tg.arn, "arn:aws:elasticloadbalancing:us-east-1:931481537897:targetgroup/", "targetgroup/")}"
    }

    scale_in_cooldown  = 30
    scale_out_cooldown = 30
  }
}