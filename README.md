# Spring Boot API with AWS EC2 Deployment
This project demonstrates how to create a Spring Boot API and deploy it to AWS EC2 using Terraform for infrastructure provisioning and GitHub Actions.

## Project Overview
The application consists of:
- Spring Boot REST API
- AWS EC2 instance for hosting
- Terraform scripts for infrastructure management
- CI/CD pipeline using GitHub Actions

## Requirements

### AWS Resources
- AWS Account with appropriate permissions
- S3 Bucket for Terraform state (can be created via terraform)

### Local Development
- Java 17
- Maven
- AWS CLI
- Terraform CLI
- Docker (recommended)

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

*Dockerfile*
- Uses Maven in the first stage to build the application
- Uses an Alpine image with JRE in the final stage, which is much smaller than the full JDK image
- Copies only the necessary JAR from the build stage

*Development tools*
```shell
# Build the application
mvn -f app clean install

# Run locally
mvn -f app spring-boot:run

# Run tests
mvn -f app test
```

*Build the docker image*
```shell
cd app

docker build -t alismed/api-ec2:latest .

docker login

docker push alismed/api-ec2:latest
```

### Infrastructure Management locally
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

## Testing GitHub Actions Locally

### Using Act
1. Install Act:
```bash
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

2. Setup test environment:
```bash
# Create test directory if not exists
mkdir -p .act

# Create env file with credentials
echo "AWS_ACCESS_KEY_ID=test" > .act/.env
echo "AWS_SECRET_ACCESS_KEY=test" >> .act/.env
echo "AWS_DEFAULT_REGION=us-east-1" >> .act/.env

# Create pull request event simulation
cat > .act/pull_request.json << EOF
{
  "pull_request": {
    "number": 1,
    "body": "Test PR",
    "head": {
      "ref": "feature/test"
    }
  }
}
EOF
```

3. Run workflows locally:
```bash
# List available workflows
act -l

# Run workflow (using .actrc config)
act -r pull_request -e .act/pull_request.json

# Run specific workflow
act -r -W .github/workflows/provisioning-ec2.yaml
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
