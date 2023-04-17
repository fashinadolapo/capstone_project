Step-by-step guide on how to build and deploy the Shopping Cart Application and Musical Concert Page to AWS using Terraform and Ansible.
Step 1: Set up AWS credentials
Before we can begin building and deploying our project to AWS, we need to set up AWS credentials. This can be done by creating an IAM user with the appropriate permissions and generating access keys. Once you have your access keys, you can configure them on your local machine using the AWS CLI.
$ aws configure
Step 2: Clone the GitHub repository
Next, we need to clone the GitHub repository for the Shopping Cart Application.
$ git clone https://github.com/fashinadolapo/Shopping-Cart-Application.git
https://github.com/fashinadolapo/Shopping-Cart-Application.git
$ git remote set-url origin https://github.com/fashinadolapo/Shopping-Cart-Application.git

Step 3: Create Terraform Infrastructure as Code
Using Terraform, we will create the infrastructure required for our project. In the root directory of the project, create a file named main.tf. This file will contain the configuration for creating the infrastructure.

Step 4: Containerize the code using Docker
•	To containerize the application using Docker, follow these steps:
•	Install Docker on the Jenkins server.
•	Create a Dockerfile in the root directory of the project with the following contents:
•	Build the Docker image by running the following command in the root directory of the project:
docker build -t dolapofashina/ Shopping-Cart-Application:v1 .
•	Push the Docker image to a Docker registry, such as Docker Hub, by running the following command:
dolapofashina/ Shopping-Cart-Application:v1

Step 5: Deploy the app with Jenkins pipeline to the Kubernetes Clusters
•	Create a Jenkins pipeline job that will execute the following stages:
•	Checkout the code from the GitHub repository
•	Build the Docker image using the Dockerfile above.
•	Push the Docker image to a Docker registry

Step 6: Use Terraform to deploy the Kubernetes Clusters and the Ingress Controller
•	Deploy the application to the Kubernetes Clusters using Kubernetes YAML files
•	Use the Kubernetes plugin for Jenkins to interact with the Kubernetes Clusters
•	Use environment variables in the Jenkins pipeline to store sensitive data such as AWS access keys and Docker Hub credentials
•	Add the necessary Kubernetes YAML files to the project directory, such as a deployment YAML file and a service YAML file, to deploy the application to the Kubernetes Clusters
•	Use kubectl commands in the Jenkins pipeline to apply the Kubernetes YAML files to the Kubernetes Clusters

Step 7: Setup an Nginx Ingress Controller for the services deployed in the K8s Cluster
•	Use Terraform to deploy the Nginx Ingress Controller to the Kubernetes Clusters
•	Use the Helm package manager to install the Nginx Ingress Controller on the Kubernetes Clusters
•	Use Kubernetes YAML files to configure the Nginx Ingress Controller to route traffic to the services deployed in the Kubernetes Clusters

Step 8: Setup a monitoring stack for the Kubernetes cluster using Prometheus and Grafana
•	To set up a monitoring stack for the Kubernetes cluster using Prometheus and Grafana, follow these steps:
•	Use Terraform to deploy Prometheus and Grafana to the Kubernetes Clusters
•	Use Kubernetes YAML files to configure Prometheus to scrape metrics from the Kubernetes Clusters
•	Use Kubernetes YAML files to configure Grafana to visualize the metrics collected by Prometheus

Step 9: Use Ansible to set up a functional web application with the simple html/CSS project
•	Install Ansible on one of the remaining EC2 instances
•	Create an Ansible playbook to install Nginx and configure it to serve the static files from the simple html/CSS project
•	Use Ansible Roles to organize the playbook into reusable modules.
•	Create Ansible roles for deploying the web application.
•	Create a new directory for the Ansible roles using the command.
•	Create a new directory for the web application using the command.
•	Create a tasks directory inside the webapp directory using the command.
•	Run the Ansible playbook on the remaining EC2 instances to set up the functional web application.
Conclusion
This guide has provided a comprehensive documentation on how to build and deploy the Shopping Cart Application and Musical Concert Page to AWS using Terraform and Ansible. By following these steps, you should be able to successfully deploy your application to AWS and set up a functional web application with the Musical Concert Page.
