### Provider Huawei Cloud and Credentials ## 
terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
      version = "1.40.2"
    }
  }
}

provider "huaweicloud" {
  region      = "${var.region}"
  access_key  = "${var.ak}"
  secret_key  = "${var.sk}"
}


################ Declaring Module VPC Working #### DONE ##############
module "vpc" {
  source              = "../modules/vpc/"
  # depends_on          = [module.eps]
  region              = "${var.region}"
  vpc_name            = "${var.vpc_name}"
  vpc_cidr            = "${var.vpc_cidr}"
  subnet_name         = "${var.subnet_name}"
  subnet_cidr         = "${var.subnet_cidr}"
  subnet_gateway_ip   = "${var.subnet_gateway_ip}"  
  app_name            = "${var.app_name}"
  environment	      = "${var.environment}"
  sg_ingress_rules    = "${var.sg_ingress_rules}"
}

############### Declaring Module RDS Working #### DONE ##############

module "rds_mysql" {
  source               = "../modules/rds_mysql/"
  depends_on           = [module.vpc]
  app_name             = "${var.app_name}"
  environment          = "${var.environment}"
  region               = "${var.region}"
  number_of_azs        = "${var.number_of_azs}"
  availability_zone    = "${var.availability_zone1}"
  availability_zone1   = "${var.availability_zone1}"
  availability_zone2   = "${var.availability_zone2}"
  vpc_name             = "${var.vpc_name}"
  subnet_name          = "${var.subnet_name}"
  rds_db_type          = "${var.rds_db_type}"
  rds_db_version       = "${var.rds_db_version}"
  rds_fixed_ip         = "${var.rds_fixed_ip}"
  rds_instance_mode    = "${var.rds_instance_mode}"
  rds_group_type       = "${var.rds_group_type}"
  rds_vcpus            = "${var.rds_vcpus}"
  rds_memory           = "${var.rds_memory}"
  rds_replication_mode = "${var.rds_replication_mode}"
  rds_init_password    = "${var.rds_init_password}"
  rds_volume_type      = "${var.rds_volume_type}"
  rds_volume_size      = "${var.rds_volume_size}"
  rds_backup_starttime = "${var.rds_backup_starttime}"
  rds_backup_keepdays  = "${var.rds_backup_keepdays}"
  time_zone            = "${var.time_zone}"
}

################## Declaring Module ECS for Image Creation Working ###### DONE ######### 
module "ecs_image" {
  source              = "../modules/ecs/"
  depends_on          = [module.vpc, module.rds_mysql]
  # depends_on          = [module.vpc,module.sfs_turbo]
  region              = "${var.region}"
  number_of_azs       = "${var.number_of_azs}"
  availability_zone   = "${var.availability_zone1}"
  availability_zone1  = "${var.availability_zone1}"
  availability_zone2  = "${var.availability_zone2}"
  subnet_name         = "${var.subnet_name}"
  app_name            = "${var.app_name}"
  environment	        = "${var.environment}"
  ecs_image_name      = "${var.ecs_image_name}"
  ecs_image_type      = "${var.ecs_image_type}"
  ecs_generation      = "${var.ecs_generation}"
  cpu_core_count      = "${var.cpu_core_count}"
  memory_size         = "${var.memory_size}"
  ecs_sysdisk_type    = "${var.ecs_sysdisk_type}"
  ecs_sysdisk_size    = "${var.ecs_sysdisk_size}"
  ecs_datadisk_number = "${var.ecs_datadisk_number}"
  ecs_datadisk_type   = "${var.ecs_datadisk_type}"
  ecs_datadisk_size   = "${var.ecs_datadisk_size}"
  ecs_attach_eip      = "${var.ecs_image_attach_eip}"
  eip_bandwidth_size  = "${var.eip_bandwidth_size}"
  remote_exec_path    = "${var.remote_exec_path}"
  remote_exec_filename= "${var.remote_exec_filename}"
  # sfs_export_location = "${module.sfs_turbo.sfs_export_location}"
}

################## Declaring Module provisioner Working #### DONE ###########
module "provision_remote_exec_image" {
  source              = "../modules/provision_remote_exec/"
  depends_on          = [module.ecs_image, module.rds_mysql]
  app_name            = "${var.app_name}"
  environment         = "${var.environment}"
  ecs_instance_eip    = "${module.ecs_image.ecs_instance_eip}"
  private_key_file    = "${var.private_key_file}"
  remote_exec_path    = "${var.remote_exec_path}"
  remote_exec_filename= "${var.remote_exec_filename}"
}


