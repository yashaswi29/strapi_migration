from dotenv import set_key, load_dotenv
import json
import os   
import sys 

rootPath = '/home/ubuntu/strapi_migration/output'

try:
    with open(f'{rootPath}/db-details.json', 'r') as f:
        db_data = json.load(f)
        print("Database details:", db_data)
except FileNotFoundError:
    print("Error: db-details.json not found")
    db_data = {}

try:
    with open(f'{rootPath}/storage-details.json', 'r') as f:
        storage_data = json.load(f)
        print("Storage details:", storage_data)
except FileNotFoundError:
    print("Error: storage-details.json not found")
    storage_data = {}

try:
    with open(f'{rootPath}/vm-details.json', 'r') as f:
        vm_data = json.load(f)
        print("VM details:", vm_data)
except FileNotFoundError:
    print("Error: vm-details.json not found")
    vm_data = {}

node_env = 'production'

database_host = db_data.get('database_hostname', 'default_host')
database_name = db_data.get('database_name', 'default_db')
database_username = db_data.get('database_username', 'default_user')
database_password = 'your_password_here'  
azure_storage_account_name = storage_data.get('storage_account_name', 'default_account')
azure_container_name = storage_data.get('container_name', 'default_container')

envPath = '/home/ubuntu/strapiApp/.env'
load_dotenv(envPath)

set_key(envPath, 'NODE_ENV', node_env)

set_key(envPath, 'DATABASE_HOST', database_host)
set_key(envPath, 'DATABASE_PORT', '1433')
set_key(envPath, 'DATABASE_NAME', database_name)
set_key(envPath, 'DATABASE_USERNAME', database_username)
set_key(envPath, 'DATABASE_PASSWORD', database_password)

set_key(envPath, 'AZURE_STORAGE_ACCOUNT_NAME', azure_storage_account_name)
set_key(envPath, 'AZURE_CONTAINER_NAME', azure_container_name)

print("Environment variables updated in .env file.")
