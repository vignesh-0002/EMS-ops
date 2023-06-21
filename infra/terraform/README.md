# Terraform Tutorial

### Terraform CLI Commands
**Syntax**: terraform [global options] <subcommand> [args]

**Initializing Working Directory**
> **terraform init** - Initialize the directory
> **terraform get** - Install or upgrade remote Terraform modules

**Writing & Modifying Code**
> **terraform fmt** - Format the configuration
> **terraform validate** - Validate the configuration
> **terraform console** - provides an interactive console for evaluating expressions

**Provisioning Infrastructure**
> **terraform plan** - Create the execution plan for previewing the infrastructure resource
> **terraform apply** - Create the infrastructure
> **terraform destroy** - Destroy the infrastructure

**Inspecting Infrastructure**
> **terraform show** - Inspect the current state 
> **terraform state list** - Manually Managing State
> **terraform output** - Prints/shows output values from the root module

**Importing Infrastructure**
> **terraform import** - Associate existing infrastructure with Terraform state

**Managing Workspace**
> **terraform workspace** - Managing multiple environments via workspace (isolation)

**Manipulating State**
> **terraform refresh** - Update the state to match remote systems
> **terraform force-unlock** - Release a stuck lock on the current workspace
> Other state related tasks such as state remove, move, edit

Referrence: https://developer.hashicorp.com/terraform/cli


### Terraform Core Concept

#### **1. Files & Directories**
> **.tf / .tf.json** - HCL and HCL based json stored in these file extension , this indicates there are terrform fsource files
> **_override.tf / _override.tf.json / override.tf / override.tf.json** - used in special case for temporarily override specific resource values
> **.terraform** - folder contains the caches, providers packages & binaries
> **.terraform.lock.hcl** - lock file that holds the version of packages, binaries and terraform current state, etc

#### **2. Hashicorp Configuration Language - GCL**
##### **- How Terraform Applies a Configuration**

Applying a Terraform configuration will:

* **Create resource**s that exist in the configuration but are not associated with a real infrastructure object in the state.
* **Destroy resource**s that exist in the state but no longer exist in the configuration.
* **Update in-place resource**s whose arguments have changed.
* **Destroy and re-create resource**s whose arguments have changed but which cannot be updated in-place due to remote API limitations.

##### **- Resource**  
Describes one or more infrastructure objects, such as virtual networks, compute instances, or higher-level components such as DNS records
A `resource` block declares that you want a particular infrastructure object to exist with the given setting
- ***Referrence*** : https://developer.hashicorp.com/terraform/language/resources
```
resource "aws_instance" "web" {
  ami           = "ami-a1b2c3d4"
  instance_type = "t2.micro"
}
```

##### **- Data Source**
Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

```
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}

```

##### **- Provider**

Terraform relies on plugins called providers to interact with cloud providers, SaaS providers, and other APIs.

Terraform configurations must declare which providers they require so that Terraform can install and use them
Every resource type is implemented by a provider; without providers, Terraform can't manage any kind of infrastructure.

```
# The default provider configuration; resources that begin with `aws_` will use
# it as the default, and it can be referenced as `aws`.
provider "aws" {
  region = "us-east-1"
}

# Additional provider configuration for west coast region; resources can
# reference this as `aws.west`.
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

```

Each Terraform module must declare which providers it requires, so that Terraform can install and use them. Provider requirements are declared in a `required_providers` block.
```
terraform {
  required_providers {
    mycloud = {
      source  = "mycorp/mycloud"
      version = "~> 1.0"
    }
  }
}

```

When `terraform init` is working on installing all of the providers needed for a configuration, Terraform considers both the version constraints in the configuration and the version selections recorded in the lock file.



##### **- Variable**
Input variables are like function arguments.

The label after the `variable` keyword is a name for the variable, which must be unique among all variables in the same module. This name is used to assign a value to the variable from outside and to reference the variable's value from within the module.

The name of a variable can be any valid identifier except the following: `source, version, providers, count, for_each, lifecycle, depends_on, locals.`

These names are reserved for meta-arguments in module configuration blocks, and cannot be declared as variable names.

```
variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}

```
##### **- Output**
Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

```
output "instance_ip_addr" {
  value       = aws_instance.server.private_ip
  description = "The private IP address of the main server instance."
}

```
##### **- Local**
A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.
Local values can be helpful to avoid repeating the same values or expressions multiple times in a configuration

```
locals {
  service_name = "forum"
  owner        = "Community Team"
}

locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}

```

##### **- More learning on HCL**
Please refer the hashicorp official documentation for terraform
https://developer.hashicorp.com/terraform/language



