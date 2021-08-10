# Cloudfront_terraform
This repository's contents will help you to provision the end-to-end Cloudfront infrastructure using infrastructure as a code (IaC). If you need to move your application/file server resources/contents to S3 and access though Cloudfront, this solution will be helpful for you.

Some examples of Cloudfront behaviors added to disable cache for certain file extension types. Eg/- *.json, *.js, *.css.  This will help you to prevent dynamic content caching if the origin S3 is updating with the latest very frequently.

## Folder structure
![Folder Structure](https://github.com/dushan566/Cloudfront_terraform/blob/main/Folder_structure.PNG?raw=true)


## prerequisite
1. S3 backend bucket
```
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key = "terraform-state-files/environment/category-name.terraform.tfstate"
    region = "eu-west-1"
    profile = "AdminRole"
    dynamodb_table = "terraform-state-lock"
  }
}
```

2. Dynamodb table
```
name = terraform-state-lock
Primary partition key =	LockID (String)
```

3. Admin Access to AWS account

## Main executable location
environments >> demo >> s3_cdn

## Usage
```
terraform init
terraform validate 
terraform plan -var-file=values.tfvars -out=terraform.out
terraform apply "terraform.out"
terraform destroy -var-file=values.tfvars
```

## Additional 
The lambda function will fix any additional slashes in your application URLs.
https://www.example.com/apps//file1.pdf
https://www.example.com/books//2021///book1.html
