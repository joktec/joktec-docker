# Organization up Kubernetes Dashboard with Helm

This guide will walk you through how to install and configure the Kubernetes Dashboard using Helm and create an admin user using a YAML file.

## Step 1: Install Helm
If you haven't already installed Helm, follow the instructions on the official [Helm website](https://helm.sh/docs/intro/install/) to install Helm on your computer.

## Step 2: Install Kubernetes Dashboard

1. Add the Kubernetes Dashboard Helm repository:
```shell
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
```

2. Install the Kubernetes Dashboard using Helm and create the kubernetes-dashboard namespace:
```shell
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

## Step 3: Create an Admin User

1. Create a YAML file (e.g., admin-user.yaml) with the following content:
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: v1
kind: Secret
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
  annotations:
    kubernetes.io/service-account.name: "admin-user"   
type: kubernetes.io/service-account-token  
```

2. Apply the YAML file to create the ServiceAccount and ClusterRoleBinding for the admin user:
```shell
kubectl apply -f admin-user.yaml
```

3. Retrieve the token for the admin user to log in to the Dashboard:
```shell
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
```
Copy the token value from the output and save it.

## Step 4: Access the Kubernetes Dashboard

1. Start a proxy to access the Kubernetes Dashboard:
```shell
export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
```
```shell
kubectl -n kubernetes-dashboard port-forward $POD_NAME 8443:8443
```
2. Open a web browser and access the following URL to log in to the Kubernetes Dashboard: https://127.0.0.1:8443/
3. When prompted for authentication method, select "Token" and paste the token you copied from Step 3.3 into the "Enter token" field. 
4. You can now access the Kubernetes Dashboard with admin privileges.

Congratulations, you have successfully set up and accessed the Kubernetes Dashboard using Helm and created an admin user. This is a powerful graphical administration interface for managing your Kubernetes cluster.




kubectl get secret $(kubectl get serviceaccount admin-user -n kubernetes-dashboard -o jsonpath="{.secret[0].name}") -o jsonpath="{.data.token}"


# Tạo một ServiceAccount mới
kubectl create serviceaccount dashboard-admin-sa -n kubernetes-dashboard

# Gán ClusterRole "cluster-admin" cho ServiceAccount
kubectl create clusterrolebinding dashboard-admin-sa-cluster-role --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin-sa


https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md
