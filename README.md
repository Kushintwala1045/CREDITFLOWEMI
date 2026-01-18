# CreditFlowEMI – DevSecOps Automation Project

![Security Scan](https://img.shields.io/badge/Security%20Scan-Passing-brightgreen) 
![CI/CD](https://img.shields.io/badge/Pipeline-Jenkins-blue)
![Cloud](https://img.shields.io/badge/Cloud-AWS-orange)

## Project Overview

CreditFlowEMI is a DevSecOps-oriented web application designed to demonstrate secure, automated application delivery using CI/CD pipelines and Infrastructure as Code (IaC). The project implements a Flask-based EMI
 Calculator and deploys it on AWS while enforcing security checks at every stage of the pipeline.

The primary focus of this project is to integrate security in the delivery lifecycle. Infrastructure configurations are scanned for misconfigurations during CI, and deployments are blocked until security risks are remediated. This approach follows the shift-left security principle, ensuring vulnerabilities are detected before reaching production.

## 2. System Architecture

### 2.1 High-Level Flow

```
Developer → GitHub → Jenkins CI/CD → Trivy Security Scan → Terraform → AWS EC2
```

### 2.2 Architecture Explanation

This architecture enforces **security gates before cloud resource creation**, preventing insecure infrastructure from being deployed.

1. Source code and infrastructure definitions are maintained in a GitHub repository.
2. Jenkins pulls the repository and executes a declarative pipeline defined in the Jenkinsfile.
3. Trivy performs static security analysis on Terraform configuration files.
4. If HIGH or CRITICAL issues are detected, the pipeline fails and blocks deployment.
5. After remediation, Terraform provisions AWS infrastructure.
6. The Flask application is deployed on an EC2 instance secured via AWS Security Groups.



## 3. Cloud Provider

**Amazon Web Services (AWS)**

### Services Used

* **EC2**: Compute instance for application hosting
* **Security Groups**: Network-level access control
* **IAM**: Secure authentication and authorization

AWS was selected due to its widespread enterprise adoption and native compatibility with Terraform.

---

## 4. Tools and Technologies

| Category               | Technology             |
| ---------------------- | ---------------------- |
| Programming Language   | Python (Flask)         |
| Containerization       | Docker, Docker Compose |
| CI/CD Automation       | Jenkins                |
| Security Scanning      | Trivy                  |
| Infrastructure as Code | Terraform              |
| Cloud Platform         | AWS                    |
| Version Control        | GitHub                 |

---

## 5. Security Report — Before and After

### 5.1 Identified Risk (Before Fix)

* Terraform Security Group allowed SSH(Port 22) access from `0.0.0.0/0`
* Classified as **HIGH severity** misconfiguration by Trivy
* Exposed EC2 instance to potential brute-force and unauthorized access attacks

**Pipeline Result:**

* Jenkins pipeline failed during Trivy scan
* Deployment was blocked


### 5.2 Security Remediation (After Fix)

* SSH access restricted to a trusted IP range (`/32`)
```
cidr_blocks = ["YOUR_IP/32"]
```
* Terraform configuration updated accordingly
* Principle of least privilege applied

**Pipeline Result:**

* Trivy scan passed successfully
* Jenkins pipeline proceeded to Terraform deployment

## 6. Jenkins Pipeline Screenshots



1. Initial failing Jenkins Trivy scan showing security violation detection
[[Fail screenshots]](https://drive.google.com/drive/folders/19aiIEjeEzJvWqLjAzqacDmUtH2gWdMvI?usp=sharing)


2. Final passing Jenkins pipeline after security remediation
[[Pass screenshots]](https://drive.google.com/drive/folders/1L_ajbxRWxqjj7NhS2yUgUU88EnILg_pr?usp=sharing)

3. Application running on the cloud Domain
[[AWS Instance screenshots]](https://drive.google.com/file/d/1WmofUagZhgf4TTkneyD0EnNz8rylYHGE/view?usp=sharing)

---

## 7. AI Usage Log 

### 7.1 Exact AI Prompt Used

```
Analyze Trivy scan results for Terraform and suggest secure fixes for the reported vulnerabilities.
```

### 7.2 Summary of Identified Risks

* Globally open SSH access on port 22
* Non-compliance with cloud security best practices
* High risk of unauthorized system access

### 7.3 AI-Recommended Improvements

* Restrict SSH access to specific trusted IP ranges

* Enforce CI/CD pipeline failure on HIGH and CRITICAL findings
* Apply security controls before infrastructure provisioning

### 7.4 Security Outcome

* All detected vulnerabilities remediated
* CI/CD pipeline enforced as a security gate
* Improved cloud security posture

---

## 8. Compliance and DevSecOps Principles

* Shift-left security implementation
* Policy enforcement via CI/CD
* Infrastructure immutability through IaC
* Automated vulnerability detection
* Secure-by-default deployment model

---

## 9. Conclusion

CreditFlowEMI demonstrates a real-world DevSecOps workflow by integrating security scanning directly into the CI/CD pipeline. The project highlights how vulnerabilities can be detected early, remediated efficiently, and prevented from reaching production using automation and AI-assisted analysis.

This project reflects industry-aligned DevSecOps practices and secure cloud deployment standards.








