#!/bin/bash 
yum update -y 
yum install httpd -y 
systemctl start httpd 
systemctl enable httpd 
echo "Hi from amazon linux built by Terraform">/var/www/html/index.html 
