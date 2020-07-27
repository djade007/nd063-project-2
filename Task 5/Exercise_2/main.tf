provider "aws" {
  region     = var.region
}

resource "aws_iam_role" "iam_4_lambda" {
  name = "iam_4_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "greeting_lambda_zip" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = "temp/greeting_l.zip"
}

resource "aws_lambda_function" "greet_lambda" {
  filename      = "temp/greeting_l.zip"
  function_name = "GreetLambda"
  role          = aws_iam_role.iam_4_lambda.arn
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.8"

  environment {
    variables = {
      greeting = "Hello Jide!"
    }
  }
}
