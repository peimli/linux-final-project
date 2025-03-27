# Serpent Surge
## Description
**Serpent Surge** is a demonstration project for the practical part of the Nix DevOps workshops. The candidates need to work on this project, to improve their practical skills after the theoretical parts.
## Forking the directory
For working with this repository in the future, you'll need to fork the repository.
1. At the upper-right corner, click on the *Fork* button
2. Name can be the same
3. Fork the repository under your **own namespace**. For example: dual-partnership/devops/DevOpsDual1/**<your_name>**/serpent-surge
4. Copying only the main branch is fine
5. Click on *Create fork*

**Important:** in the future, make every necessary change to your fork only.
## Note
Before starting to work on the project, check the code and try to understand what is the purpose of each component.
## Contact
In case of questions about this project, you can reach me at the following e-mail address:

Mate Torma: mate.torma@nixs.com

##  Tech Stack

| Component     | Tool/Service                 |
|---------------|------------------------------|
| **Cloud**      | AWS (EC2, RDS, S3)           |
| **Infra as Code** | Terraform                   |
| **Configuration Mgmt** | Ansible               |
| **App Runtime** | Docker + docker-compose     |
| **Web Server** | Nginx (reverse proxy)        |
| **Database**   | Amazon RDS (MySQL 8.0)       |
| **Backup**     | Systemd timer + S3 upload    |

---

##  Features

-  **Infrastructure provisioning** via Terraform
-  **EC2 Ubuntu server** for app hosting
-  **RDS MySQL** database for storing game scores
-  **Daily database backups** to S3 using systemd timers
-  **Dockerized frontend and backend**
-  **Ansible automation** to install Docker, deploy containers, and configure system services
-  **Nginx reverse proxy** to expose the app cleanly on port 80

---

## How to deploy?

-   **git clone**
-   **cd terraform**
-   **terraform init**
-   **terraform apply**
This will:

    🔸 Create an EC2 instance (Ubuntu)

    🔸 Launch an RDS MySQL database

    🔸 Create an S3 bucket for backups

    🔸 Generate and import an SSH key

    🔸 Output values such as the public IP, RDS endpoint, and S3 bucket name
3. Update Ansible Variables:
    - **ansible/inventory.ini** Update the EC2 IP address from Terraform output
    - **ansible/docker-compose.yml** Update environment variables for the backend container using Terraform outputs:
 4. Run Ansible Playbook:
    -   cd ../ansible
    - ansible-playbook -i inventory.ini playbook.yml
    This will:

    Install Docker + Docker Compose on the EC2 server

    Deploy the frontend and backend containers

    Configure Nginx as a reverse proxy

    Copy the backup script

    Register a systemd timer to back up your DB to S3 daily

5. Access Your App:
    - Open a browser and go to:
    **http://<your-ec2-public-ip>**

