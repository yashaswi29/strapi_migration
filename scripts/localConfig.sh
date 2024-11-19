#!/bin/bash


npm install mssql
npm install @azure/storage-blob
npm install @azure/cosmos

cp $terraform_rootDir_path/config/database.js $local_project_rootDir_path/config/database.js
cp $terraform_rootDir_path/config/plugins.js $local_project_rootDir_path/config/plugins.js

echo "Dependencies for SQL Server, Azure Blob Storage, and Cosmos DB installed and configuration files copied."

