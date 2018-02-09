#!/bin/bash
# Feb 8, 2018
# Kirk Dahl
# 
# Azure Deep Dive Training
# Final Project - Microsoft Azure Batch

clear
echo "STOP - have you logged into Azure yet? (y/n)"
read answer
case $answer in
   y) ;;
   n) exit;;
   *) exit;;
esac

##########################################
########## PREREQUISITES #################
##########################################


#CREATE RESOURCE GROUP
echo
echo
echo ======================================
echo "Creating Resource Group"
echo ======================================
az group create \
    --name rg-kirkdahl \
    --location eastus

#CREATE STORAGE ACCOUNT
echo
echo
echo ======================================
echo "Creating Storage Account"
echo ======================================
az storage account create \
    --resource-group rg-kirkdahl \
    --name sakirkdahl \
    --location eastus \
    --sku Standard_LRS

#CREATE VNET
echo
echo
echo ======================================
echo "Creating VNET"
echo ======================================
az network vnet create \
    --name vnet-kirkdahl \
    --resource-group rg-kirkdahl \
    --subnet-name subnet-kirkdahl


################################################################
########## BEGIN THE MICROSOFT BATCH INSTALLATION ##############
################################################################

#CREATE BATCH ACCOUNT
echo
echo
echo ======================================
echo "Creating Batch Account"
echo ======================================
az batch account create \
    --name batchkirkdahl \
    --storage-account sakirkdahl \
    --resource-group rg-kirkdahl \
    --location eastus

#UPLOAD APPLICATION
echo
echo
echo ======================================
echo "Creating Application Package"
echo ======================================
az batch application package create \
  --resource-group rg-kirkdahl \
  --name batchkirkdahl \
  --application-id PartyApp \
  --package-file ./18.zip \
  --version 1.0

#CREATE JOB
echo
echo
echo ======================================
echo "Creating Job"
echo ======================================
az batch job create \
    --id PartyApp \
    --account-name batchkirkdahl \
    --account-endpoint https://batchkirkdahl.eastus.batch.azure.com \
    --pool-id webservers

#CREATE TASKS – using json files
echo
echo
echo ======================================
echo "Creating Job Tasks"
echo ======================================
# FIRST TASK UNZIPS WEBSITE CODE
az batch task create \
--job-id PartyApp \
--account-name batchkirkdahl \
--account-endpoint https://batchkirkdahl.eastus.batch.azure.com \
--json-file ./batch-task.json 


# SECOND TASK RESTART APACHE SERVER
az batch task create \
--job-id PartyApp \
--account-name batchkirkdahl \
--account-endpoint https://batchkirkdahl.eastus.batch.azure.com \
--json-file ./batch-task2.json 

#CREATE BATCH POOL
echo
echo
echo ======================================
echo "Creating Batch Pool"
echo ======================================
az batch pool create \
  --template batch-pool.json \
  --account-name batchkirkdahl \
  --account-endpoint https://batchkirkdahl.eastus.batch.azure.com








