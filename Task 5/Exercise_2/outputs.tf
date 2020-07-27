output "lambda_name" {
  description = "Lambda Name"
  value = aws_lambda_function.greet_lambda.function_name
}
