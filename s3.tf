resource "aws_s3_bucket" "siva-artifactory" {
   bucket = "artifactory-cicd-siva" 
  
  tags = {
    "name" = "artifactory-cicd-siva"
  }
}