# 🚀 Memos on AWS ECS Fargate

This project deploys **Memos**, an open-source, privacy-first note-taking and knowledge management platform, into a **production-ready AWS environment** using:

- **Docker** for containerization  
- **Terraform** for infrastructure provisioning  
- **ECS Fargate** for serverless container orchestration  
- **GitHub Actions** for CI/CD automation  
- **Prometheus & Grafana** for monitoring  
- **CloudWatch & S3** for logging  
- **Route 53 & ACM** for DNS and HTTPS  

The architecture emphasizes **security, scalability, automation, and observability**.

---

## 🧭 Architecture Diagram

<p align="center">
  <img src="images/diagram.png" width="850" alt="AWS Architecture Diagram"/>
</p>

---

## 🔁 CI/CD Pipeline

<p align="center">
  <img src="images/pipeline.png" width="850" alt="CI/CD Pipeline Diagram"/>
</p>

---

## 📁 Repository Structure

ECS-MEMOS-PROJECT/
|-- .github/
| |-- workflows/
| | -- ci-cd.yml |-- app/ |-- docker/ |-- configs/ |-- images/ | |-- diagram.png | -- pipeline.png
|-- terraform/
| |-- main.tf
| |-- output.tf
| |-- provider.tf
| |-- terraform.tfvars
| |-- variables.tf
| -- modules/ | |-- acm/ | |-- alb/ | |-- ecr/ | |-- ecs/ | |-- ecs_task/ | |-- ecs_service/ | |-- iam/ | |-- route53/ | |-- vpc/ | |-- security/ | |-- logs/ | |-- cloudwatch_explorer/ | |-- prometheus/ | |-- grafana/ | -- monitoring_s3/


---

## 🌐 Overview

This deployment includes:

✅ End-to-end HTTPS using ACM  
✅ AWS Application Load Balancer  
✅ ECS Fargate containers  
✅ Docker image pipelines to ECR  
✅ Infrastructure as Code (Terraform)  
✅ Fully automated CI/CD  
✅ Monitoring via Prometheus and Grafana  
✅ Centralized logging with CloudWatch and S3  
✅ DNS using Route 53  
✅ Hardened container runtime  

---

## 🏗 Infrastructure Design

### Networking

- Custom multi-subnet VPC  
- Public subnets for ALB  
- Private subnets for ECS  
- NAT Gateway for outbound access  
- Strict Security Groups  

### ECS Fargate

- Serverless container runtime  
- No public IPs for tasks  
- Load-balanced architecture  
- Horizontal scalability  

### Load Balancer & TLS

- Port 80 redirected to HTTPS  
- ACM provides SSL certificates  
- Health-based routing  

---

## 🐳 Docker & Container Security

- Non-root container user  
- Minimal base image  
- ENTRYPOINT enforced  
- Vulnerability scans via Trivy  
- Secrets never baked into images  

---

## 🏗 Terraform Implementation

- Modular design  
- S3 remote backend  
- DynamoDB state locking  
- Versioned infrastructure  
- IAM least-privilege permissions  

---

## 🔁 CI/CD Automation

The pipeline is defined in:

.github/workflows/ci-cd.yml

yaml
Copy code

### Pipeline Stages

1. Code push to GitHub  
2. Docker image build  
3. Trivy vulnerability scan  
4. Image pushed to ECR  
5. Terraform plan  
6. Apply infrastructure  
7. ECS service deployment  

---

## 📊 Observability

### Monitoring

- Prometheus scrapes metrics  
- Grafana visualizes health  
- CloudWatch Explorer aggregates logs  

### Logging

- Application logs in CloudWatch  
- Archived to S3 for retention  
- Service-specific log groups  

---

## 🔐 Security Features

| Feature | Status |
|----------|--------|
| HTTPS encryption | ✅ |
| Private ECS services | ✅ |
| IAM least privilege | ✅ |
| Network isolation | ✅ |
| Secrets in GitHub | ✅ |
| Container scanning | ✅ |
| Firewall rules | ✅ |
| Audit-ready logging | ✅ |

---

## 🚀 Run Locally

```bash
docker run -d \
  -p 5230:5230 \
  -v ~/.memos:/var/opt/memos \
  neosmemo/memos:stable
Access:

arduino
Copy code
http://localhost:5230
🌍 Production URL
arduino
Copy code
https://memos.yourdomain.com
✅ Why This Setup?
Enterprise-grade hosting

Fully automated deployments

Secure-by-design infrastructure

Observability baked in

Disaster recovery ready

Modular Terraform design

CI-driven releases

🎯 Future Enhancements
WAF protection

Auto-scaling policies

Secrets Manager

Database backend (RDS)

Blue/green deployments

Backup automation

👨‍💻 Author
Built by [Abdikarim Yusuf]
Cloud / DevOps Engineer