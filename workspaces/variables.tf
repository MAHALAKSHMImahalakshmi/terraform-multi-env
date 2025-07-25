variable "project" {
    default = "roboshop"
}
/*variable "environment" {
  # ===> vars default = "dev"
}*/ # terraform.workspace


/* variable "final-name" {
    default = "${var.project}-${var.environment}-${var.component}"
} */

variable "common_tags" {
   default = {
        Project = "roboshop"
        Terraform = "true"
    }
}
variable "ami_id" {
  type        = string
  default     = "ami-09c813fb71547fc4f"
  description = "AMI-id OF JOINDEVOPS rhel 9"
}
variable "sg_name" {
  default = "allow-all"
}
variable "discription" {
  default=" all ports from all IP"
}
variable "to_port" {
    type = number
  default = 0
}

variable "from_port" {
    type = number
  default =  0
}

variable "cidr_blocks" {
    type= list(string)
  default = ["0.0.0.0/0"]
}
variable "instances" {
  default = ["mongodb","redis"]
}

variable "instance_type" {
  default = {
    dev = "t3.micro",
    prod = "t3.small"
  }
}