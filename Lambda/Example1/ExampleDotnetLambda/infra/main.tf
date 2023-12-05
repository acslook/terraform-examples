#Exemplo com pacote zip

locals {
  lambda_zip_location = "outputs/ExampleDotnetLambda.zip"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "${path.module}/../src/ExampleDotnetLambda/bin/Release/net6.0"
  output_path = local.lambda_zip_location
}

resource "aws_iam_role" "lambda_role" {
  name               = "Test_Lambda_Function_Role"
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

resource "aws_lambda_function" "example_lambda" {
  filename      = local.lambda_zip_location
  function_name = "example_terraform_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ExampleDotnetLambda::ExampleDotnetLambda.Function::FunctionHandler"
  runtime       = "dotnet6"
  publish       = true
}

output "source_dir" {
  value = "${path.module}/../src/ExampleDotnetLambda/bin/Release/net6.0"
}