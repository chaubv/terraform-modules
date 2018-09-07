###You need change region, access key and securet key of your

provider "aws" {
access_key = "AKIAIBUNBPTAB6WUFULA"
secret_key = "tgtPpF9zu5C1q1Mc6T+oLBx7eeEBctjGh0hXwDNj11"
region = "us-east-2"
}

###Create EFS file System 

resource "aws_efs_file_system" "efs" {
  creation_token = "veritone"

  tags {
    Name = "veritone"
  }
}
###Create EFS mount taget,you need change with your subnet_id

resource "aws_efs_mount_target" "alpha" {
  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id      = "subnet-093133969fffc4202"
 security_groups = ["${aws_security_group.efs.id}"]
}

###Create a security group allow inbound rule port 2049, EC2 can connect to EFS, You need change your vpc_id 

resource "aws_security_group" "efs" {
  name        = "AWS_NFS"
  description = "Allow NFS traffic."
  vpc_id      = "vpc-05fb3f1285e3fd88c"

###You can change 0.0.0.0/0 with subnetmask or ip of EC2

ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

###Outbound rule allow traffic

egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




