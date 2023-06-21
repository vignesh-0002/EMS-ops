# Full Stack Web Application - Phase 2
In this section, we will learn how to build the basic Infrastructure

This phase includes

- Building Basic Infrastructure with Terraform on AWS
- Topics Covered
  - **Terraform** 
    - Concepts : Providers, Resources, Data Sources, Variables, Outputs, Locals
    - Actions : Profile setting, Initialisation, Creation, Modification, Destroying and State Management of Infrastructure
  - **Cloud** : AWS
    - EC2, AMI    

For terraform basic tutorial : [Terraform Tutorial](infra/terraform/README.md)
For previous phases : [Project Phases](#project-phases) 
### Prerequisites
To follow this tutorial you will need:

#### 1. Terraform CLI
For traditional and single version of terrform users can follow this link and setup the terraform on the respective machine
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform

The tfswitch command line tool lets you switch between different versions of terraform
https://tfswitch.warrensbox.com/Install/


#### 2. AWS CLI 
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

#### 3. AWS account & credentials
- Connect to AWS account, create access id and secret key
  
## Scenarios : Infrastructure Build 
All the infrastructure related codes are present under the folder `infra` and IaC is under `terraform`
 ### 1. Define Providers
All the required providers and aws configuration goes under the file `infra/terraform/terraform.tf`

The following snippet describes the `terraform` and `provider` blocks where, 
**`terraform`** block holds
- list of provide that are required by the code 
- source of the provider (public repo and name of the provider) 
- version , exact or higher version of the provider defined
- required_version is the version of terraform used on this project (exact or higher version), ie., the terrform version installed on the vm/jenkins/any medium must be equal or greater than `required_version`
- after the mentioned providers will be downloaded to `.terraform` folder post `terraform init`

**`provider`** block holds
- configuration of the provider 
- in our case we have user `aws` as our provider, so the argument like `region`,`profile` can be set here
  
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

```
 ### 2. Export AWS Credentials
- Setup AWS credentials on the terminal where the terraform cli are to be issued/executed.
- Copy the Access Id and Secret created from the section [3. AWS account & credentials](#3-aws-account--credentials)
  ```
  export AWS_ACCESS_KEY_ID=
  export AWS_SECRET_ACCESS_KEY=
  ```

 ### 3. Build As-Is
 #### - - Initialize 
- This step is to initialise the terafform working directory by issing `terraform init` command.
- This stage will 
  - create a directory named `.terraform`
  - download the packages/providers from public repositories
```
terraform inir
```

 #### - - Format & Validate
 - This stage will
   - correct the lint issues
   - validate the correctness of terraform syntax and dependencies used
  ```
     terraform fmt
     terraform validate
  ```
  
 #### - Plan the infrastructure
 - This stage will
   - generates the visual output on the console to describe what are all the resources that will be created in target
```
terraform plan
```  
 #### - Apply the infrastructure
 - This stage will
   - creates the resources to target as per what had been shown in the plan output
```
terraform apply
```  
##### Points to note
- see how variables are used
- capture the values of the output post terraform apply
- 
 ### 4. Change the AMI
 #### - Find & Change the AMI ID
- Find the AMI Id of Ubuntu 20.04 LTS on the region `us-east-1`
- Change the value of AMI Id on `main.tf` file

 #### - Observe the Change
- Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply

### 5. Change the Value of a variable
 #### - Find & Change value of a variable
 - change the value of `environment` variable from `variables.tf` file
- Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply
### 6. Add a new variable
 #### - Add a new vairable
 - add a new variable named `creation_time` in `variables.tf` file
 - create a new tag ID `CreationTime` in `main.tf` and refer the variable `creation_time`
  - Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply
  
### 7. Use Locals
 #### - Auto-Generate a Value
 - auto generate the value of variable `creation_time` using locals
 - create a new file named `locals.tf`
 - declare a locals block in that file
 - create 2 local variable `lcreation_time` and `lcreation_time_formated`in that block (_`lcreation_time - complete timestamp, lcreation_time_formated - formatted timestamp`_)
 - add a command to get current date and time
 - replace the reference of `CreationTime` in `main.tf` from `creation_time` variable to local variable `lcreation_time`
 - create a new tag value `CreationTimeFormated` and refer it to `lcreation_time_formated`
 - Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply
  
**code block for locals**  
```dotntcli
locals {
  lcreation_time = timestamp()
  lcreation_time_formated = formatdate("YYYYMMDDhhmmss", timestamp())
}
```
 ### 8. Use Data Source
 #### - Use data source to fetch AMI ID
 - create a file named `data.tf`
 - add a data source block to get the AMI ID for `ubuntu 20.04 LTS`
 - replace the value of AMI Id on `main.tf` file from string to reference of data source
 -  Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply
  
**code block for data**
```
data "aws_ami" "ubuntu_20_04" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}
```
**resource update in main.tf**
```
resource "aws_instance" "ems_ops" {
  ami           = data.aws_ami.ubuntu_20_04.id
```
 ### 9. Add AWS Profile
 #### - Add AWS Profile to the terminal
 - add AWS profile to the terminal from where the terraform is executed
 - use AWS CLI to setup the profile in terminal, use the following command and fill up the ID and Key
  ```
  aws configure --profile ems-dev
  ```
 #### - Add AWS Profile to the terraform
 - add the profile to `provider` block  in `terraform.tf` file
 - export the AWS profle in the terminal before running the terraform apply
 -  Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply
```
export AWS_PROFILE=ems-dev
```
**code block for provider**
```
provider "aws" {
  region = "us-east-1"
  profile = "ems-dev"
}
```
 ### 10. Get new output value
 #### - Add a new output block
 - add a new output block for `Availability Zone` of the created instance in the `outputs.tf` file
 -  Apply the changes in the infrastructure using `terrform apply`
- capture the values of the output post terraform apply

 ### 11. Understand State
 #### - Look at the terraform state file created
 - `.terraform.tfstate` is the file that holds all the infrastructure details and metadata

 ### 12. Destroy All
 #### - Destroy the infrastructure
 - reun `terraform destroy` to destroy all the resources created by the terraform code.

