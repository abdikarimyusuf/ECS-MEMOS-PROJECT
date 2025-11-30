# Memos on AWS ECS Fargate

This project deploys **Memos**, an open-source, privacy-focused note-taking platform, into a production-grade AWS environment using modern cloud and DevOps practices.

The platform is designed and deployed as a **three-tier architecture** using AWS managed services, Infrastructure as Code, and CI/CD automation.

---

## Technology Stack

**Core tools used:**

- Docker – containerisation  
- Terraform – infrastructure as code  
- AWS ECS Fargate – serverless container orchestration  
- Amazon RDS (PostgreSQL) – persistent database backend  
- Amazon ECR – container registry  
- GitHub Actions – CI/CD automation  
- AWS CloudWatch – logging and monitoring  
- AWS Secrets Manager – secure secrets injection  
- Route 53 – DNS management  
- AWS ACM – HTTPS / TLS certificates  
- Application Load Balancer – traffic routing and health checks  

---

## Architecture Overview

This environment follows a **three-tier cloud architecture pattern**.

### Presentation Tier
- Route 53 DNS and HTTPS via ACM  
- Application Load Balancer (ALB)  
- Secure routing to ECS  

### Application Tier
- ECS Fargate running Docker containers  
- No public IPs  
- Internal NAT access  
- Horizontally scalable  

### Data Tier
- Amazon RDS (Postgres)  
- Private subnets only  
- Access controlled via Security Groups  
- Credentials stored in Secrets Manager  

---

## Architecture Diagram

![Architecture Diagram](application.png)

---

## CI/CD Pipeline

The deployment pipeline is fully automated using GitHub Actions.

### Pipeline Flow

1. Code pushed to GitHub  
2. Docker image build  
3. Vulnerability scan with Trivy  
4. Image push to ECR  
5. Terraform plan  
6. Terraform apply  
7. ECS service update  
8. Rolling deployment  

Pipeline File:

.github/workflows/ci-cd.yml

yaml
Copy code

---

## Repository Structure

ECS-MEMOS-PROJECT/
├── README.md
├── app/
│ └── memos/
├── docker/
│ └── Dockerfile
├── terraform/
│ ├── main.tf
│ ├── output.tf
│ ├── provider.tf
│ ├── terraform.tfvars
│ ├── variables.tf
│ └── modules/
│ ├── acm/
│ ├── alb/
│ ├── ecr/
│ ├── ecs/
│ ├── ecs_service/
│ ├── ecs_task/
│ ├── iam/
│ ├── logs/
│ ├── route53/
│ ├── security/
│ └── vpc/

yaml
Copy code

---

## Infrastructure Design

### Networking

- Custom VPC  
- Public subnets for ALB  
- Private subnets for ECS and RDS  
- NAT Gateway for outbound networking  
- Security Groups control access  

### ECS Fargate

- Serverless architecture  
- No SSH access  
- Stateless workloads  
- Scales horizontally  

### Load Balancer & HTTPS

- HTTP redirected to HTTPS  
- TLS certificates via ACM  
- Health checks on tasks  
- Supports rolling updates  

---

## Docker & Container Security

- Multi-stage builds  
- Linux compiled binary  
- Non-root runtime  
- Small base image  
- Enforced ENTRYPOINT  
- Secrets injected at runtime  
- Image scanning in CI  

---

## Terraform Design

- Modular structure  
- S3 remote state backend  
- DynamoDB state locking  
- Least-privilege IAM roles  
- Version-controlled infrastructure  

---

## Security Controls

| Feature | Status |
|---------|--------|
| HTTPS encryption | Yes |
| Private subnets | Yes |
| Secrets Manager | Yes |
| IAM least privilege | Yes |
| Network isolation | Yes |
| Logging | Yes |
| Container hardening | Yes |

---

## Observability

### Logging
- Application logs in CloudWatch  
- Service-specific log groups  
- Centralised logging  

### Monitoring
- Load balancer health checks  
- ECS service monitoring  
- CloudWatch metrics  

---

## Run Locally

```bash
docker run -d \
  -p 5230:5230 \
  -v ~/.memos:/var/opt/memos \
  neosmemo/memos:stable
Open:

arduino
Copy code
http://localhost:5230
Production URL
arduino
Copy code
https://memos.yourdomain.com
Why This Setup?
Production grade cloud deployment

Infrastructure as Code

Secure design

Automated pipelines

Highly available architecture

Scalable system

Real-world DevOps practices

Future Enhancements
Auto scaling

Blue/green deployments

Backups and restores

RDS replicas

WAF protection

Cost monitoring

Disaster recovery plans

Author
Built by Abdikarim Yusuf
Cloud / DevOps Engineer