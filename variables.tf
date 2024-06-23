# T-Pot Security Settings
variable "admin_ip" {
  type        = string
  description = "Admin IP addresses in CIDR format (allow access to the T-Pot management service)"
}

# CLOUD ACCOUNT / SUBSCRIPTION / PROJECT Settings
variable "aws_allowed_account_id" {
  type        = string
  description = "AWS account ID for deploying T-Pot"
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID for deploying T-Pot"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID for deploying T-Pot"
}

# NETWORK Settings
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
}
