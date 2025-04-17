\# EC2 Nginx Deployment with Terraform - Step-by-Step Guide

## Overview
This document outlines the step-by-step process to deploy an Nginx web server on an Ubuntu EC2 instance using Terraform. The setup strictly adheres to the requirements and constraints mentioned in the assignment brief, ensuring a minimal and efficient configuration.

## Prerequisites (on AWS Environment Only)
Before you begin, ensure the following prerequisites are in place **within the AWS environment**:

1. **AWS Account Access**
   - Ensure that you have access to an AWS account with permissions to create EC2 instances, security groups, and key pairs.

2. **Amazon EC2 Key Pair**
   - Navigate to EC2 Dashboard → Key Pairs
   - Create a key pair named `<your-key-name>` (DO NOT include `.pem` in the name)
   - Download the private key file and store it securely on your local machine if needed for SSH

3. **AWS CLI Configuration (on AWS CloudShell or EC2 Linux instance)**
   ```bash
   aws configure
   ```
   Provide your Access Key ID, Secret Access Key, Region (e.g., `ap-south-1`), and Output format (`json`)

4. **Install Terraform (Amazon Linux Instance)**
   ```bash
   sudo yum install -y yum-utils
   sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
   sudo yum -y install terraform
   terraform -version
   ```

5. **Create a Project Directory**
   ```bash
   mkdir terraform-nginx-ubuntu
   cd terraform-nginx-ubuntu
   ```

6. **Ensure Proper IAM Permissions**
   - The IAM role or user should have at least the following permissions:
     - `ec2:RunInstances`
     - `ec2:TerminateInstances`
     - `ec2:CreateSecurityGroup`
     - `ec2:AuthorizeSecurityGroupIngress`
     - `ec2:DescribeInstances`

## Steps to Deploy Nginx using Terraform on AWS

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Review the Execution Plan**
   ```bash
   terraform plan
   ```

3. **Apply the Configuration to Launch Resources**
   ```bash
   terraform apply -auto-approve
   ```

4. **Verify Deployment**
   - Copy the public IP from the Terraform output
   - Open the IP address in a web browser
   - You should see: `Welcome to the Terraform-managed Nginx Server on Ubuntu`

5. **SSH into Instance (Optional)**
   ```bash
   ssh -i "<your-key-name>.pem" ubuntu@<PUBLIC_IP>
   ```
   *Ensure you are using the correct username (`ubuntu`) and key path.*

6. **Destroy Resources (Clean Up)**
   ```bash
   terraform destroy -auto-approve
   ```

## Troubleshooting Tips

- **Key Pair Not Found Error**:
  - Make sure the key pair name in the Terraform variable matches exactly with the one created in AWS (case-sensitive).

- **Permission Denied for SSH**:
  - Check if your `.pem` file has correct permissions (`chmod 400` if needed locally).
  - Verify the instance is using the correct AMI and the user is `ubuntu` for Ubuntu 20.04.

- **Invalid Expression or Block Definition in Terraform**:
  - Ensure that heredoc syntax for `user_data` starts with `<<EOF` and ends with `EOF` with no indentation.

- **Incorrect attribute value for Security Group**:
  - When referencing the security group in `vpc_security_group_ids`, always pass its `id` attribute.

## Note
- All the required code is provided in the repo 

## Next Steps
- Include necessary Terraform files (`main.tf`, `variables.tf`, `outputs.tf`)
- Attach screenshots showing successful deployment

