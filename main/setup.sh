#!/bin/bash
# setup.sh
# Purpose: Automate EKS cluster creation + RBAC + token extraction

set -e

echo "🔧 Initializing Terraform..."
terraform init -upgrade

echo "Running terraform apply..."
terraform apply -auto-approve

echo "Waiting for EKS cluster to be ready..."
CLUSTER_NAME=$(terraform output -raw cluster_name)
REGION="ap-south-1"

echo "Updating kubeconfig..."
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$REGION"

echo "Fetching Jenkins token..."
SECRET_NAME=$(kubectl get sa jenkins -n webapps -o jsonpath="{.secrets[0].name}")
JENKINS_TOKEN=$(kubectl get secret "$SECRET_NAME" -n webapps -o jsonpath="{.data.token}" | base64 --decode)

echo "Jenkins ServiceAccount Token:"
echo "$JENKINS_TOKEN"