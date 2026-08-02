environment = "dev"

bootstrap_image = "public.ecr.aws/docker/library/nginx:alpine"

subdomain_name = "analytics.tahmidchoudhury.uk"

domain_name = "tahmidchoudhury.uk"

aws_region = "eu-west-2"

# rds

engine         = "postgres"
engine_version = "18.3"
instance       = "db.t3.micro"
storage_size   = 20
storage_type   = "gp2"

# ecs

cpu             = 256
memory          = 512
container_port  = 3000
number_of_tasks = 1