## Creating Application load balancer, target group and listener on port 80.

resource "aws_lb" "my_lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.alb_public1.id,aws_subnet.alb_public2.id]
  security_groups    = [aws_security_group.alb_sg.id] 
}

resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id

health_check {
  interval = 7
 }
}

data "aws_instance" "asg_instance" {
  filter {
    name    =  "tag:Name"
    values   =  ["${aws_autoscaling_group.web_asg.name}"]
 }
}

resource "aws_lb_target_group_attachment" "my_attachment" {
  target_group_arn = "${aws_lb_target_group.my_target_group.arn}"
  target_id        = "${data.aws_instance.asg_instance.id}"
  port             = 80
}


resource "aws_alb_listener" "my_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.my_target_group.id
    type             = "forward"
  }
}
