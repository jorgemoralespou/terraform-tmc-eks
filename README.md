# Management of EKS clusters via Tanzu Mission Control
This repository creates an EKS cluster via Tanzu Mission Control (TMC). In the process it will also create a VPC for your cluster, as this is something TMC will not do and expects an existing VPC.

You can check in [variables.tf](./variables.tf) the required variables for this module and the defaults for some of them

## How to create

- Edit your specific variables for your install creating a `.tfvars` file with these variables and the values appropriate for your setup:
  
  ```
   # Uncomment and modify. Values that are commented are the defaults
   endpoint = "<TMC-ENDPOINT>"
   vmw_cloud_api_token="<VMWARE-CLOUD-TOKEN>"
   credential_name = "<MY-TMC-EKS-CREDENTIALS-NAME>"
   cluster_group = "<TMC-CLUSTER-GROUP>" // You can use "Default"
   region = "<AWS-REGION>"
   name_prefix = "<RESOURCE-NAMES-PREFIX>"
   #kubernetes_version = "1.24"
   #desired_nodes=2
   #max_nodes=6
   #min_nodes=2
   #instance_types = [
   #  "c6i.xlarge",
   #]
   ```

- Run terraform apply with your variables
  ```
  terraform apply -var-file="my-vars.tfvars"
  ```

- Wait for terraform to finish. Once that happens, you should see your cluster in TMC UI and you should also see the created resources in AWS (VPC, EKS, EC2, ...)

*NOTE*: Sometimes a first run might fail. Wait a bit and try again, if it fails again, ping me.

## How to destroy

- Run terraform destroy to delete all the generated resources
  ```
  terraform destroy
  ```

- Wait for terraform to finish. Now everything should have been deleted. *NOTE* If there's any error while deleting the resources, ping me to troubleshoot.

### KNOWN ISSUES

There seems to be a problem when deleting the VPC because some resources are not properly deleted. Namely the ELB in ec2 is one of them. You need to manually log into AWS console and delete this resource if the `destroy` fails, and run it again. This might happen randomly with other resources.