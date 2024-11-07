Create configuration templates (e.g., plugin.js.tpl) to inject deployment-specific values. This will repolace config/plugin.js by itself when terraform is provisioned.
Use file and remote-exec provisioners to apply configurations and restart Strapi after setup.
Pass sensitive info (e.g., Azure connection strings) as environment variables to Terraform.
Be cautious with provisioners, as they may complicate Terraform’s state tracking.
Use Terraform for infrastructure and a Bash script for detailed app configuration if needed.

Step1: first set the strapi up on Azure, along wiht other componenentsw of blob and cosmosdb.

Step2: then test the code thoroughly after running and testing, writing main.tf and terraform code for the same of it to be used at many places whenever required.

and strict to the strategy without changing anything.