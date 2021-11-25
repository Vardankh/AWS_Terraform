# This is target tracking policy based on CPU.

resource "aws_autoscaling_policy" "web_target_tracking" {
  name = "web_target_tracking"
  autoscaling_group_name = aws_autoscaling_group.web_asg.name
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 30.0
  }

}
