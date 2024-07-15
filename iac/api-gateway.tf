# API GATEWAY
resource "aws_api_gateway_rest_api" "central_api" {
  name = "Obl-Devops-API-Gateway"
}


resource "aws_api_gateway_resource" "orders_resource" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  parent_id   = aws_api_gateway_rest_api.central_api.root_resource_id
  path_part   = "orders"
}

resource "aws_api_gateway_resource" "shipping_resource" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  parent_id   = aws_api_gateway_rest_api.central_api.root_resource_id
  path_part   = "shipping"
}

resource "aws_api_gateway_resource" "shipping_by_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  parent_id   = aws_api_gateway_resource.shipping_resource.id
  path_part   = "{id}"
}

resource "aws_api_gateway_resource" "products_resource" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  parent_id   = aws_api_gateway_rest_api.central_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_resource" "product_by_id_resource" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  parent_id   = aws_api_gateway_resource.products_resource.id
  path_part   = "{id}"
}




resource "aws_api_gateway_method" "orders_method" {
  rest_api_id   = aws_api_gateway_rest_api.central_api.id
  resource_id   = aws_api_gateway_resource.orders_resource.id
  http_method   = "POST"
  authorization = "NONE"
  request_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method" "shipping_method" {
  rest_api_id   = aws_api_gateway_rest_api.central_api.id
  resource_id   = aws_api_gateway_resource.shipping_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "shipping_by_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.central_api.id
  resource_id   = aws_api_gateway_resource.shipping_by_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_method" "products_method" {
  rest_api_id   = aws_api_gateway_rest_api.central_api.id
  resource_id   = aws_api_gateway_resource.products_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "product_by_id_method" {
  rest_api_id   = aws_api_gateway_rest_api.central_api.id
  resource_id   = aws_api_gateway_resource.product_by_id_resource.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.id" = true
  }
}



resource "aws_api_gateway_integration" "orders_integration" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.orders_resource.id
  http_method = aws_api_gateway_method.orders_method.http_method
  type        = "HTTP"
  uri         = "http://${aws_lb.prod_orders_lb.dns_name}/orders"  
  integration_http_method = "POST"
  request_templates = {
    "application/json" = "$input.body"
  }
}

resource "aws_api_gateway_integration" "shipping_integration" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.shipping_resource.id
  http_method = aws_api_gateway_method.shipping_method.http_method
  type        = "HTTP"
  uri         = "http://${aws_lb.prod_shipping_lb.dns_name}/shipping"  
  integration_http_method = "GET"
}

resource "aws_api_gateway_integration" "shipping_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.central_api.id
  resource_id             = aws_api_gateway_resource.shipping_by_id_resource.id
  http_method             = aws_api_gateway_method.shipping_by_id_method.http_method
  type                    = "HTTP"
  uri                     = "http://${aws_lb.prod_shipping_lb.dns_name}/shipping/{id}"
  integration_http_method = "GET"
  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}

resource "aws_api_gateway_integration" "products_integration" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.products_resource.id
  http_method = aws_api_gateway_method.products_method.http_method
  type        = "HTTP"
  uri         = "http://${aws_lb.prod_products_lb.dns_name}/products"  
  integration_http_method = "GET"
}

resource "aws_api_gateway_integration" "product_by_id_integration" {
  rest_api_id             = aws_api_gateway_rest_api.central_api.id
  resource_id             = aws_api_gateway_resource.product_by_id_resource.id
  http_method             = aws_api_gateway_method.product_by_id_method.http_method
  type                    = "HTTP"
  uri                     = "http://${aws_lb.prod_products_lb.dns_name}/products/{id}"
  integration_http_method = "GET"
  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }
}





resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.products_integration,
    aws_api_gateway_integration_response.products_200,
    aws_api_gateway_method_response.products_200,
    aws_api_gateway_integration.product_by_id_integration,
    aws_api_gateway_integration_response.product_by_id_200,
    aws_api_gateway_method_response.product_by_id_200,
    aws_api_gateway_integration.shipping_by_id_integration,
    aws_api_gateway_integration_response.shipping_by_id_200,
    aws_api_gateway_method_response.shipping_by_id_200,
    aws_api_gateway_integration.orders_integration,
    aws_api_gateway_integration_response.orders_200,
    aws_api_gateway_method_response.orders_200
  ]

  rest_api_id = aws_api_gateway_rest_api.central_api.id
  stage_name  = "prod"
}



###########RESPUESTAS API GATEWAY ###########


############PRODUCTS##############
resource "aws_api_gateway_integration_response" "products_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.products_resource.id
  http_method = aws_api_gateway_method.products_method.http_method
  status_code = "200"
  response_templates = {
    "application/json" = "$input.body"
  }
  depends_on = [aws_api_gateway_integration.products_integration]
}


resource "aws_api_gateway_method_response" "products_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.products_resource.id
  http_method = aws_api_gateway_method.products_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }

  depends_on = [aws_api_gateway_integration.products_integration]
}

############PRODUCTS BY ID##############

resource "aws_api_gateway_integration_response" "product_by_id_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.product_by_id_resource.id
  http_method = aws_api_gateway_method.product_by_id_method.http_method
  status_code = "200"
  response_templates = {
    "application/json" = "$input.body"
  }
  depends_on = [aws_api_gateway_integration.products_integration]
}

resource "aws_api_gateway_method_response" "product_by_id_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.product_by_id_resource.id
  http_method = aws_api_gateway_method.product_by_id_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_integration.products_integration]
}
############SHIPPING BY ID##############
resource "aws_api_gateway_integration_response" "shipping_by_id_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.shipping_by_id_resource.id
  http_method = aws_api_gateway_method.shipping_by_id_method.http_method
  status_code = "200"
  response_templates = {
    "application/json" = "$input.body"
  }
  depends_on = [aws_api_gateway_integration.shipping_by_id_integration]
}

resource "aws_api_gateway_method_response" "shipping_by_id_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.shipping_by_id_resource.id
  http_method = aws_api_gateway_method.shipping_by_id_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_integration.shipping_by_id_integration]
}


############orders by products ids##############

resource "aws_api_gateway_integration_response" "orders_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.orders_resource.id
  http_method = aws_api_gateway_method.orders_method.http_method
  status_code = "200"
  response_templates = {
    "application/json" = "$input.body"
  }
  depends_on = [aws_api_gateway_integration.orders_integration]
}

resource "aws_api_gateway_method_response" "orders_200" {
  rest_api_id = aws_api_gateway_rest_api.central_api.id
  resource_id = aws_api_gateway_resource.orders_resource.id
  http_method = aws_api_gateway_method.orders_method.http_method
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  depends_on = [aws_api_gateway_integration.orders_integration]
}