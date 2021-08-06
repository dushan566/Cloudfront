# Cloudfront_terraform
This repository's contents will help you to provision the end-to-end Cloudfront infrastructure using infrastructure as a code (IaC).
Following use cases are addressed under this solution.

If you want to host a static website on AWS S3 bucket and service traffic through a Cloudfront distribustion,

Move your application/file server resources/contents to S3 and access though Cloudfront

Sometimes we need to host our resources/contents in a file server and retrieve them through a frontend website. In this case you have to use "cloudfront_s3" module and make the S3 ACL as "private"

Some examples of Cloudfront behaviors added to disable cache for certain file extension types. Eg/- *.json, *.js, *.css.  This will help you to prevent dynamic content caching if the origin S3 is updating with the latest very frequently.
