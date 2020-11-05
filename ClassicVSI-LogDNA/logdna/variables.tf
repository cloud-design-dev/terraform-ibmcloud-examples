variable region {}
variable plan {
  description = "The plan type for LogDNA"
  type        = string
  default     = "7-day"
}

variable resource_group {}
variable name {
  default = "logdnatest"
}