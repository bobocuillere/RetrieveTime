# Final Project Documentation

![Architecture Diagram](architecture.png)

## 1. Quick How to

### Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform ≥ 1.5 installed
- Docker with buildx extension (Because of my Apple CPU compatibility with Fargate architecture)

### Steps to Deploy Infrastructure

```bash
git clone <repo-url>
cd <repo-dir>
make deploy    # initializes Terraform, Push to ECR with my script, Deploy the full infra
```

### Access the App

```bash
terraform output app_url
```

Visit this URL in your browser to verify:
- Frontend loads successfully
- Backend data fetching works (`/api/time`)

### Monitoring Verification

Access AWS CloudWatch to check:
- **Alarms**:
    - CPU utilization
    - Memory usage
    - ALB 5xx errors
    - Latency metrics
    - CloudFront 5xx rate
- **Logs**: ECS task logs under `/dataiku/<project>-logs`

### Steps to Destroy the Infrastructure

1. Delete all objects from the S3 Bucket (`sophnel-assessment-static-<id>`)
2. Delete the Docker image from the ECR repository (`sophnel-assessment-api`)
3. Run destroy command:
     ```bash
     terraform destroy
     ```

## 2. AWS Architecture Overview

The architecture chosen is based on the requirements while remaining future-proof for potential infrastructure growth.

### Core Architecture

#### CloudFront CDN
- Single secure endpoint handling static and dynamic requests
- Optimized for speed and caching via CDN
- Two distinct origins:
    - S3 Origin (index.html and static assets)
    - ALB Origin (/api/* routes)
- Enables caching for static assets and dynamic routing for API

#### Static Frontend Hosting (S3)
- Serves frontend static files securely via CloudFront Origin Access Control (OAC)
- Private bucket with strictly controlled access via CloudFront distribution
- Cost-effective with high durability (11 nines)

#### Dynamic Backend (ECS Fargate)
- Runs containerized backend API (Flask app) across 2 AZs
- High availability with ≥ 2 task replicas
- Serverless approach simplifies operations with no server management

#### Application Load Balancer (ALB)
- Distributes HTTP traffic across ECS tasks
- HTTPS capability requires domain configuration
- Security Group limits traffic to CloudFront managed prefix lists

### Networking

#### VPC & Subnets
- Redundant 2-AZ configuration
- Public Subnets: ALB and NAT Gateways
- Private Subnets: Isolated ECS tasks without direct external exposure

#### NAT Gateway
- Enables secure internet access for private subnet ECS tasks
- Required for Docker image pulls and log shipping

### Security
- ECS tasks isolated in private subnets behind ALB
- ALB restricted to CloudFront prefix lists
- Private S3 bucket with CloudFront OAC access only

#### TLS/HTTPS
- Default CloudFront TLS certificate (*.cloudfront.net)
- Secure HTTPS traffic without additional configuration
- Future custom domain support possible for HTTPS on the ALB

### Monitoring and Alerting

#### CloudWatch Alarms
- ECS: CPU (>80%) and Memory (>80%) thresholds
- ALB: 5xx errors and latency monitoring
- CloudFront: 5xx error rate tracking
- ECS backend logs available in CloudWatch Logs

### Infrastructure as Code (IaC)
- Modular Terraform approach
- Remote state management via S3 and DynamoDB locking

## 3. Traffic Flow

1. Client Request: User opens CloudFront URL
2. CloudFront CDN: Delivers index.html and static assets directly from S3
3. Frontend API Call: React application makes requests to /api/time
4. Dynamic Request Routing: CloudFront routes /api/* requests to ALB origin
5. ALB & ECS Interaction: ALB forwards requests to ECS tasks running Flask API
6. Response: JSON response from backend delivered back through ALB → CloudFront → Browser
