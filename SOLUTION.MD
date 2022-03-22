## Analyze the project requirements
   Web Application written in Go language is needed to be deployed in any cloud platform. Application is designed to use postgres database to store application data. 
## Initial tests performed
   Application is compiling and running locally on desktop.
   Able to create docker image locally and connect to container via SSH 
## High level Decisions 
   Code is forked from https://github.com/servian/TechChallengeApp/ and cloned on local machine on developement
   Used AWS environment as Cloud platform to run the application 
   Use Terraform as Infrastructure as code 
   Learn and try to run CircleCI as pipeline
## Technical Decisions and process flow
   1) Generate AWS key and secret for new user to run terraform deployment
   2) Store environment variables in circleci as they are protected by masking automatically
   Following environment variables are stored in Circle CI 
   AWS_REGION               = "Add Default AWS region to deploy infrastructure"
   TF_DBUSER                = "Postgres Admin User Name "
   TF_DBPASSWORD            = "postgres password This is dummpy example"
   TF_DBSUBNETGROUP         = "Subnet group to place prosgres instance"
   tag_prefix               = "Tag all the assets to better identification"
   ECR_REPOSITORY           = ""
   dynamodb_table_statelock = "apptechc-statelocktable"
   3) Connect CircleCI project with Github forked repository
   4) Terraform code to use S3 bucket as backend storage == Create this resource manually and assign permission policies which will allow terraform user to intract with S3 bucket
   5) Terraform code to create dynamodb resource to store backend locking and with lifecycle hook.. (Note: this resource needed to be saved from accidental removal and deleted first from state file to allow destruction  )
   6) Terraform code to generate Network resources like (Private / public subnets, VPC, Internet Gateway, NAT Gateway, loadbalancer, DatabaseSubnet Group and security groups)
   7) Terraform code to create Database resource (Note: this module needs variables to set username and password for database )
   8). Terraform code to Create compute resources like (iam resources, ECR Respository, Cloud Watch group, ECS Cluster, ECS Task defination and ECS Service ). This module is attaching service to VPC's Security Group (SG) and allowing load balancer's SG to be able to talk to ECS)
   9). Terraform to update local files conf.toml  and ecr_repourl each time pipeline runs.
       Conf.toml stores database url and authentication information. 
       ecr_repourl stores the ECR url 
   10). Add Circle CI approval stage to verify terraform plan each time before changing resources on AWS with Terraform apply( Apply only when feature branch was merged on master).
   11). Create docker container via CircleCI pipeline step and push to ECR. This needs to run only when feature branch was merged on master and Approval Step is needed to this stage. 
## Completion Critiria  
   Screenshots are added to each pull request.
   Pipeline is successfully Tested.
   Final screeshots are added to screenshot folder. 
## Final Stage
   Destory resources to stop incurring cost. 
   Please contact me to spin up the infrastructure