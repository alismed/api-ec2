# Spring Boot API with AWS EC2 Deployment
This project demonstrates how to create a Spring Boot API and deploy it to AWS EC2 using Terraform for infrastructure provisioning and GitHub Actions.

## Project Overview
The application consists of:
- Spring Boot REST API
- AWS EC2 instance for hosting
- Terraform scripts for infrastructure management
- CI/CD pipeline using GitHub Actions

## Requirements

### Local Development
- Java 17
- Maven
- AWS CLI
- Terraform CLI
- Docker (recommended)
- Localstack CLI (recommended)

### AWS Resources
- AWS Account with appropriate permissions
- S3 Bucket for Terraform state (can be created via terraform)

## Setup Instructions

### AWS Configuration
1. Configure AWS CLI credentials:
   ```shell
   aws configure
   ```
2. For LocalStack testing, add profiles in:
   - `.aws/credentials`
   - `.aws/config`

### Application Build & Run
```shell
# Build the application
mvn -f app clean install

# Run locally
mvn -f app spring-boot:run

# Run tests
mvn -f app test
```

### Infrastructure Management
```shell
# Initialize Terraform
terraform -chdir=infra init

# Format Terraform files
terraform -chdir=infra fmt

# Plan changes
terraform -chdir=infra plan

# Apply changes
terraform -chdir=infra apply -auto-approve

# Destroy infrastructure
terraform -chdir=infra destroy -auto-approve
```

## Project Structure
```
api-ec2/
├── app/               # Spring Boot application
├── infra/             # Terraform infrastructure code
└── .github/workflows/ # GitHub Actions CI/CD
```

## Infrastructure Details
- The Terraform state is stored in an S3 bucket (configured in `backend.tf`)
- EC2 instance hosts the Spring Boot application
- Security groups and networking are managed via Terraform

## CI/CD Pipeline
- GitHub Actions workflow triggers on branches prefixed with `feature/`
- Set the AWS credentials on the secrets of the project
- Pipeline steps:
  1. Build and test application
  2. Run Terraform validation
  3. Deploy infrastructure
  4. Deploy application

## Contributing
1. Create a new feature branch (`feature/your-feature`)
2. Commit your changes
3. Push to the branch
4. Create a Pull Request

## Troubleshooting
- Ensure AWS credentials are properly configured
- Check EC2 instance logs in CloudWatch
- Verify security group settings if API is unreachable
