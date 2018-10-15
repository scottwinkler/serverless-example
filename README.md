# Serverless-Example
This is a fully serverless app that runs on AWS and is deployed using terraform. The basic architecture is:
AWS Lambda (for the golang server)
AWS APIGateway (for proxying all requests to lambda)
AWS S3 (for hosting the static content for the react app)
AWS RDS (for storing data)

It is an extremely scalable solution -- it costs less than $0.20 per month to host in AWS, and can easily scale to tens of thousands of concurrent users with only minor configuration modifications.
 
hosted at http://sjw-example-dev.s3-website-us-west-2.amazonaws.com/