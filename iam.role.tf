
# create a role 
resource "aws_iam_role" "cicd-apache" {
  name = "cicd-apacheserver"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "cicd-apacheserver"
  }
}

# create a policy

resource "aws_iam_policy" "cicd-policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}




resource "aws_iam_role_policy_attachment" "cicd-role" {
  role       = aws_iam_role.cicd-apache.name
  policy_arn = aws_iam_policy.cicd-policy.arn
}

resource "aws_iam_instance_profile" "cicd-iam" {
  name = "test_profile"
  role = aws_iam_role.cicd-apache.name
}