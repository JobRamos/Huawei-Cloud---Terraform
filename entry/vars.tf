variable "ak" {  default = "Agrega tu AK aqui" }
variable "sk" {  default = "Agrega tu SK aqui" }
variable "app_name" {  default = "iaac" }
variable "environment" {  default = "production" }
variable "time_zone" {  default = "UTC-05:00" }
variable "enterprise_project_exist" {  default = "1" }
variable "region" {  default = "la-north-2" }
variable "number_of_azs" {  default = "2" }
variable "availability_zone1" {  default = "la-north-2a" }
variable "availability_zone2" {  default = "la-north-2c" }
variable "vpc_name" {  default = "vpc_iaac" }
variable "vpc_cidr" {  default = "10.10.0.0/16" }
variable "subnet_name" {  default = "subnet_iaac" }
variable "subnet_cidr" {  default = "10.10.1.0/24" }
variable "subnet_gateway_ip" {  default = "10.10.1.1" }
variable "sg_ingress_rules" {  
    type        = map(map(any))
    default     = {
        rule1 = {from=22, to=22, proto="tcp", cidr="0.0.0.0/0", desc="SSH Remotely Login from Internet for Linux"}
        rule2 = {from=3389, to=3389, proto="tcp", cidr="0.0.0.0/0", desc="RDP Remotely Login from Internet for Windows"}
        rule3 = {from=80, to=80, proto="tcp", cidr="0.0.0.0/0", desc="Access Webserver HTTP from Internet"}
        rule4 = {from=443, to=443, proto="tcp", cidr="0.0.0.0/0", desc="Access Webserver HTTPs from Internet"}
        rule5 = {from=3306, to=3306, proto="tcp", cidr="10.10.0.0/16", desc="Access RDS from the VPC CIDR"}
        rule6 = {from=6379, to=6379, proto="tcp", cidr="10.10.0.0/16", desc="Access VPC from the VPC CIDR"}
        rule7 = {from=3000, to=3000, proto="tcp", cidr="0.0.0.0/0", desc="Access node webpage from Internet"}
    }
 }
variable "ecs_generation" {  default = "s6" }
variable "cpu_core_count" {  default = "1" }
variable "memory_size" {  default = "2" }
variable "ecs_image_name" {  default = "Debian 10.0.0 64bit" }
variable "ecs_image_type" {  default = "public" }
variable "ecs_sysdisk_type" {  default = "GPSSD" }
variable "ecs_sysdisk_size" {  default = "40" }
variable "ecs_datadisk_number" {  default = "0" }
variable "ecs_datadisk_type" {  default = "GPSSD" }
variable "ecs_datadisk_size" {  default = "300" }
variable "public_key_file" {  default = "id_rsa.pub" }
variable "ecs_image_attach_eip" {  default = true }
variable "eip_bandwidth_size" {  default = "50" }
variable "ecs_retention_time_period" {  default = "90" }
variable "sfs_retention_time_period" {  default = "180" }
variable "alarm_email_address" {  default = "abcd@abc.com" }
variable "private_key_file" {  default = "id_rsa" }
variable "remote_exec_path" {  default = "/root" }
variable "remote_exec_filename" {  default = "auto_installation_ecs_cluster.sh" }
variable "rds_db_type" {  default = "MySQL" }
variable "rds_db_version" {  default = "8.0" }
variable "rds_fixed_ip" {  default = "10.10.1.158" }
variable "rds_instance_mode" {  default = "single" }
variable "rds_group_type" {  default = "general" }
variable "rds_vcpus" {  default = "2" }
variable "rds_memory" {  default = "8" }
variable "rds_replication_mode" {  default = "async" }
variable "rds_init_password" {  default = "Huawei123+" }
variable "rds_volume_type" {  default = "CLOUDSSD" }
variable "rds_volume_size" {  default = "100" }
variable "rds_backup_starttime" {  default = "05:15-06:15" }
variable "rds_backup_keepdays" {  default = "180" }
variable "desire_instance_number" {  default = "1" }
variable "min_instance_number" {  default = "1" }
variable "max_instance_number" {  default = "3" }
variable "cool_down_time" {  default = "900" }
variable "launch_time" {  default = "07:00" }
variable "recurrence_type" {  default = "Daily" }
variable "start_time" {  default = "2022-07-21T12:00Z" }
variable "end_time" {  default = "2023-07-30T12:00Z" }

