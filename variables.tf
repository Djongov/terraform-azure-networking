# Name of the resource group, it will be used for placing resources in this group, it might come from the module output or be a string
variable "resource_group_name" {
  description = "Name for the resource group"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Project name for the resources"
  type        = string
}

variable "repo_name" {
  description = "name of the repository"
  type        = string
  default = null
}
# Location for the resources, it will be used in naming and tagging of resources
variable "location" {
  description = "Location for the resources"
  type        = string
  default     = "westeurope"
}

# Plays a role in naming and tagging of resources
variable "environment" {
  description = "Environment for the application"
  type        = string
}

# Subscription id for where to deploy the resources
variable "subscription_id" {
  description = "Subscription id"
  type        = string
}

# Common tags that will be applied to all resources
variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "vnets" {
  description = "List of vnets to create"
  type        = map(object({
    address_space       = list(string)
    subnets             = list(object({
      name            = string
      address_prefix  = string
      service_endpoints = optional(list(string))
    }))
    enable_ddos_protection = optional(bool)
    enable_vm_protection   = optional(bool)
    tags = optional(map(string))
  }))
  default     = {}
}