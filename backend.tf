terraform {
  backend "s3" {
    bucket = "my-terraformafeez"
    key    = "mykey.tfstate"
    region = "us-east-1"
  
  }
}