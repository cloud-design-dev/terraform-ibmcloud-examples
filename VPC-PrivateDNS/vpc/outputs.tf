output vpc_id {
    value = module.vpc.id 
}

output subnet_id {
     value = module.subnet.id 
}

output sg_id {
    value = module.vpc.default_security_group
}