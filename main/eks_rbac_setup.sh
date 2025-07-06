# cluster 

CLUSTER_NAME=$(terraform -chdir=/var/lib/jenkins/workspace/tarn/terraform output -raw cluster_name)
REGION="ap-south-1"

echo "Updating kubeconfig..."
aws eks update-kubeconfig --name "$CLUSTER_NAME" --region "$REGION"

is_cluster_ready() {
  STATUS=$(aws eks describe-cluster \
    --name "$CLUSTER_NAME" \
    --region "$REGION" \
    --query "cluster.status" \
    --output text)

  [ "$STATUS" = "ACTIVE" ]
}

# Wait loop
until is_cluster_ready; do
  echo "Cluster not ready. Waiting 60 seconds..."
  sleep 60
done

echo "Cluster is ACTIVE. Running kubectl"

# Creating ns
echo "creating ns"
kubectl create ns webapps

# create sa and role
echo "creating sa"
kubectl apply -f sa.yaml
echo "creating role"
kubectl apply -f role.yaml
echo "rolebinding"
kubectl apply -f rolebinding.yaml
kubectl apply -f secret.yaml
