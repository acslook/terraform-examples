#Exemplo com pacote bucket S3

# data "aws_s3_bucket_object" "package" {
#   bucket = "acs-app-artifacts/lambda"
#   key    = "lambda_package.zip"
# }

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
  s3_bucket = "acs-app-artifacts"
  s3_key = "lambda/lambda_package.zip"
  function_name    = "example_terraform_lambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "ExampleDotnetLambda::ExampleDotnetLambda.Function::FunctionHandler"
  runtime          = "dotnet6"
  publish          = true
}

# output "Hash" {
#   value = data.aws_s3_bucket_object.package.metadata.Hash
# }