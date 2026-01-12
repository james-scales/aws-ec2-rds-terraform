
locals {
  name_prefix = "armageddon-class7"
  db_prefix   = "lab-mysql"
  terraform_tag = "made in Terraform"
}


##### Creating locals block to pull public & private subnets for route table resource

### Loop through all subnets created by aws_subnet.that, and 
### collect the ids of each subnet only if its type is "public" & "private".

##### Creating locals block to pull public subnets for NAT gateway resource

### Loop through all subnets created by aws_subnet.that, and 
### collect the ids of each subnet only if its type is "public".

locals {
  public_subnet_ids = [
    for k, s in aws_subnet.dev :
    s.id if var.subnets[k].type == "public"
  ]
}

locals {
  public_subnets = {
    for k, s in aws_subnet.dev : k => s
    if var.subnets[k].type == "public"
  }
  private_subnets = {
    for k, s in aws_subnet.dev : k => s
    if var.subnets[k].type == "private"
  }
}

# Loops over each private subnet key and creates a route table association
# Toset used to convert a list into a set which is useful for for_each