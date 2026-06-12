module "vpc" {
  source = "../modules/aws/vpc"
  env    = "stg"
}

module "subnet" {
  source = "../modules/aws/subnet"
  env    = "stg"
  vpc_id = module.vpc.id_cloud_pratica
}

module "igw" {
  source = "../modules/aws/igw"
  env    = "stg"
  vpc_id = module.vpc.id_cloud_pratica
}

module "route_table" {
  source            = "../modules/aws/route_table"
  env               = "stg"
  vpc_id            = module.vpc.id_cloud_pratica
  igw_id            = module.igw.id_igw
  public_subnet_ids = local.public_subnet_ids
}

