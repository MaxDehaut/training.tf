#!/bin/bash

# 1- Create resource group
az group create --name "rgTfTraining" --location westeurope

# 2- Create storage account
az storage account create --resource-group "rgTfTraining" --name "storagetfbackend" --sku Standard_LRS --encryption-services blob

# 3- Create blob container
az storage container create --name "tfstate" --account-name "storagetfbackend"

# 4- Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group "rgTfTraining" --account-name "storagetfbackend" --query [0].value -o tsv)

echo $ACCOUNT_KEY