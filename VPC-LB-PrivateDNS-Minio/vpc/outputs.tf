output default_security_group {
  value = module.vpc.default_security_group
}

output id {
  value = module.vpc.id
}

output subnet_id {
  value = module.subnet.id
}