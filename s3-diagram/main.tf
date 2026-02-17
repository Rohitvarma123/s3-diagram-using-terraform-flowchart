provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "site" {
  bucket = "rohit-terraform-puzzle-diagram-9999"
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.site.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "ec2" {
  bucket       = aws_s3_bucket.site.id
  key          = "ec2.html"
  source       = "ec2.html"
  content_type = "text/html"
}

resource "aws_s3_object" "igw" {
  bucket       = aws_s3_bucket.site.id
  key          = "igw.html"
  source       = "igw.html"
  content_type = "text/html"
}

resource "aws_s3_object" "vpc" {
  bucket       = aws_s3_bucket.site.id
  key          = "vpc.html"
  source       = "vpc.html"
  content_type = "text/html"
}

