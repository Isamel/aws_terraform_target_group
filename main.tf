resource "null_resource" "depends_on" {
    triggers = {
        depends_on = join("", var.alb_target_group_depends_on)
    }
}

resource "aws_alb_target_group" "alb_target_group_terraform" {
    count                   = var.alb_target_group_count
    depends_on              = [null_resource.depends_on]
    name                    = var.alb_target_group_name
    port                    = var.alb_target_group_port
    protocol                = var.alb_target_group_protocol
    vpc_id                  = var.alb_target_group_vpc_id
    stickiness {
        type                = var.alb_target_group_stickiness_type
        cookie_duration     = var.alb_target_group_stickiness_cookie_duration
    }
    health_check {
        path                = var.alb_target_group_health_check_path
        healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
        unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
        timeout             = var.alb_target_group_health_check_timeout
        interval            = var.alb_target_group_health_check_interval
        matcher             = var.alb_target_group_health_check_matcher
        protocol            = var.alb_target_group_protocol
    }
    tag                     = local.tags
}