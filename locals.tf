locals {
  tags  = merge(
      map("key", "resource_name", "value", var.alb_target_group_name),
      var.extra_tags
  )
}