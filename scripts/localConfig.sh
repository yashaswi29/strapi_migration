#!/bin/bash

local_project_rootDir_path=$1
terraform_rootDir_path=$2

# Change to the local project directory
cd $local_project_rootDir_path

# Install SQL Server client for Node.js (mssql)
npm install mssql

# Install the Azure Storage Blob SDK for interacting with Azure Blob Storage
npm install @azure/storage-blob

# Install the Azure Cosmos DB client for Node.js
npm install @azure/cosmos

# Copy the database.js file from the Terraform directory to the local project directory
cp $terraform_rootDir_path/config/database.js $local_project_rootDir_path/config/database.js

# Copy the plugins.js file from the Terraform directory to the local project directory
cp $terraform_rootDir_path/config/plugins.js $local_project_rootDir_path/config/plugins.js

# (Optional) If you're using Azure storage to store uploaded files, you may want to include other configurations.
# E.g., Azure file upload provider setup for Strapi (if applicable, otherwise skip this step)
# npm install @strapi/provider-upload-azure-storage

# Output message indicating setup completion
echo "Dependencies for SQL Server, Azure Blob Storage, and Cosmos DB installed and configuration files copied."

# Optional: If you want to include some further configuration or steps, you can add them here.
