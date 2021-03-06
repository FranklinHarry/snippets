# Set Required Variables:

`AWS_DEFAULT_REGION="us-west-2"`

# Create, Update and Delete an EKS Cluster

## Validate CloudFormation
`aws cloudformation validate-template --template-body file://eks_introduction.yaml`

## Create the VPC and EKS Cluster
`aws cloudformation create-stack --stack-name eks-introduction --capabilities CAPABILITY_IAM --template-body file://eks_introduction.yaml`

## Update the VPC and EKS Cluster
`aws cloudformation update-stack --stack-name eks-introduction --capabilities CAPABILITY_IAM --template-body file://eks_introduction.yaml`

## Delete the VPC and EKS Cluster
`aws cloudformation delete-stack --stack-name eks-introduction`

# Update Security Groups

1. Update EKSClusterSecurityGroup to allow port 443 in from Worker Nodes.
2. Update EKSWorkerSecurityGroup to allow any protocol, any port from EKSWorkerSecurityGroup.

# Configure kubectl

## Configure the kubectl Config File

1. Copy the "Certificate Authority" value and paste into "Clusters:certificate-authority-data" field.
2. Copy the "API Server Endpoint" value and paste into "server" field.
3. Copy the "Cluster Name" value and paste into the "users:name:user:exec:args:[3]" field.

## Test

Run: `kubectl get pods --namespace kube-system` - this may show a number of "Pods" pending as the nodes are not yet able to register.

# Allow Node Registration to Cluster

## Configure Kubernets to Allow Node Registration

1. Copy the ECS Worker IAM Role ARN (example: arn:aws:iam::187376578462:role/eks-introduction-EKSWorkerIAMRole-1J7MIA0PTXKQ1)
2. Paste this into the aws-auth-cm.yaml file.
3. Run the following: `kubectl apply -f aws-auth-cm.yaml`
4. Confirm the ConfigMap has been added: `kubectl get configmaps --namespace kube-system` - the `aws-auth` configmap should be available.

## Confirm Node Registration

Run `kubectl get nodes`

## Confirm Additional Pods Running

Healthy worker nodes run a number of pods - launching these pods requires node registration.

Run: `kubectl get pods --namespace kube-system`

# Troubleshooting

## Node Registration Failure:

1. Confirm Proper Node Registration Authentication. See step "Configure Kubernets to Allow Node Registration"
2. Review Logs `journalctl -u kubelet.service`
