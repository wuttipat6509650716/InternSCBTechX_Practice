# 🚀 Step-by-Step Guide

### 1. Login to Microsoft Azure

Authenticate with Azure using the CLI:
```bash
az login
```
### 2. Clone This Repository
Use Git to clone the project:
```bash
git clone https://github.com/wuttipat6509650716/InternSCBTechX_Practice.git
cd InternSCBTechX_Practice
```
### 3. Provision Azure VM Using Terraform
```bash
cd terraform
terraform apply
```
-   Type  `yes`  when prompted to confirm the infrastructure creation.
    
-   Once complete, Terraform will output the  **public IP address**  of your VM.
    
-   **Copy this IP address**  – you will use it in the next step.
### 4. Configure Ansible Inventory
Navigate to the Ansible directory:
```bash
cd ../ansible
```
Edit the `hosts` file and insert the public IP from the Terraform step:
```bash
<your-vm-ip> ansible_user=azureuser ansible_ssh_private_key_file=~/.ssh/id_rsa
```
Replace `<your-vm-ip>` with your actual VM IP.
### 5. Run the Ansible Playbook
Execute the Ansible playbook to install and configure the logging and monitoring tools:
```bash
ansible-playbook -i hosts starter.yml
### (Optional) Cleanup
To delete all Azure resources and clean up the infrastructure, run:
```bash
cd ../terraform
terraform destroy
```
This will deprovision the VM and remove all associated resources.
