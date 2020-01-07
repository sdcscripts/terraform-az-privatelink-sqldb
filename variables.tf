variable "rg_prefix" {
 type = "string"
 description = "resource group name prefix to use to create resource groups"
 }

variable "rg_location" {
 type = "string"
 description = "resource group location to use for all resources"
 }

variable "vm_hostname" {
 type = "string"
 description = "the hostname for the vm to be used to connect to the sql database over private link"
 }

variable "vm_admin_user" {
 type = "string"
 description = "the username to use for the vm admin account"
 }

 variable "vm_admin_pwd" {
 type = "string"
 description = "the password to use for the vm admin account - should meet complexity requirements"
 }

 variable "vm_public_dns_prefix" {
 type = "string"
 description = "the prefix to use for the DNS label that will be set for the public IP of the created vm"
 }

 variable "vm_size" {
 type = "string"
 description = "the vm size to use during vm creation"
 }

 variable "net_sub_cidr" {
 type = "list"
 description = "a comma seperated list of subnets cidr values. two required minimum"
 }

 variable "net_sub_name" {
 type = "list"
 description = "a comma seperated list of subnet names. two required minimum and same number as there are net_sub_cidr entries"
 }

  variable "net_endpoint_sub_cidr" {
 type = "string"
 description = "a comma seperated list of subnet names. two required minimum and same number as there are net_sub_cidr entries"
 }

 variable "sql_svr_name_prefix" {
 type = "string"
 description = "prefix for the sql server instance name"
 }

variable "sql_svr_ver" {
 type = "string"
 description = "version of sql server instance"
 }

variable "sql_admin_user" {
 type = "string"
 description = "the username to use for the sql admin account"
 }

 variable "sql_admin_pwd" {
 type = "string"
 description = "the password to use for the sql admin account - should meet complexity requirements"
 }

  variable "sql_db_edition" {
 type = "string"
 description = "criticality tier of the database. production workloads will probably utilise businesscritical or hyperscale"
 }

  variable "sql_db_service_objective_name" {
 type = "string"
 description = "Purchasing model to use for the database. serverless vs vcore etc"
 }