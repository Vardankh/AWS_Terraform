# Creating launch template to be used in web autoscaling group.

resource "aws_launch_template" "webserver_launch_temp" {
  name                                  =  "webserver_launch_temp"
  instance_initiated_shutdown_behavior  = "terminate"        
  disable_api_termination               = false
  image_id                              = "ami-09ce2fc392a4c0fbc"
  instance_type                         = "t2.micro"
  user_data                             = filebase64("./user_data.sh")
  key_name                              = "key94" 

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.web_private.id
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
	resource_type = "instance"
         
    tags = {
      Name = "web_asg"
    }
  }
}

