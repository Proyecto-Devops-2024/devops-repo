
# Create S3 Bucket per environment with for_each and maps
resource "aws_s3_bucket" "s3bucketFrontendDevops" {

  for_each = {
    dev  = "my-devapp-devops-bucket"
    test = "my-testapp-devops-bucket"
    prod = "my-prodapp-devops-bucket"
  }

  bucket = "${each.key}-${each.value}"
  acl    = "private"

  tags = {
    eachvalue   = each.value
    Environment = each.key
    bucketname  = "${each.key}-${each.value}-Devops"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  for_each = aws_s3_bucket.s3bucketFrontendDevops

  bucket = each.value.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  for_each = aws_s3_bucket.s3bucketFrontendDevops

  bucket = each.value.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  for_each = aws_s3_bucket.s3bucketFrontendDevops

  bucket = each.value.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${each.value.id}/*"
        ]
      }
    ]
  })
}