provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "webserver" {
  ami = "ami-03a71cec707bfc3d7"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = <<EOF
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4
echo "<h2>WebServer with IP: $myip</h2><br>Build by Terraform! " > /var/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
}

resource "aws_security_group" "webserver" {
  name = "WebServer Security Group"
  description = "Security Group for WebServer"

  ingress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  } 

  ingress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 443
    protocol = "tcp"
    to_port = 443
  } 

   egress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
  } 
}