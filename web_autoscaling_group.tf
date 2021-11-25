#creating AutoScaling Group

resource "aws_autoscaling_group" "web_asg" {
  name                      = "web_asg"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  health_check_grace_period = 50
  health_check_type         = "EC2"
  wait_for_capacity_timeout = "7m"
  termination_policies      = ["OldestInstance"]
  vpc_zone_identifier       = [ aws_subnet.web_private.id]


  launch_template {
    id      = aws_launch_template.webserver_launch_temp.id
    version = "$Latest" 
 } 

  tag {
       key                 = "Name"
       value               = "web_asg"
       propagate_at_launch = true
 }
            
  
}
