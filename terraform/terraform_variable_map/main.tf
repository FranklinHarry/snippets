variable aws_region {
  default="us-west-2"
}

# Not Kidding - the official AWS EKS AMI is not available via
# aws ec2 describe-images --region us-west-2 --owner amazon 
# aws ec2 describe-images --region us-west-2 --owner 602401143452 --filter Name=name,Values="eks*"

variable "eks_ami_for_region" {
  type = "map"
  default = {
    "us-east-1" = "ami-dea4d5a1"
    "us-west-2" = "ami-73a6e20b"
  }
}

output "ami_id" {
  value = "AMI id for region ${var.aws_region} is ${var.eks_ami_for_region[var.aws_region]}"
}
