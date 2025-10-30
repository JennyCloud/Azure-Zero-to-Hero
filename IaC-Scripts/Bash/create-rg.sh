#!/bin/bash
# =========================================
# File: create-rg.sh
# Purpose: Create and verify an Azure Resource Group using Bash and Azure CLI
# =========================================

# ---------- Variables ----------
rgName="DemoLab-RG"
location="canadacentral"

# ---------- Step 1. Display Purpose ----------
echo "Creating a Resource Group named '$rgName' in region '$location'..."
echo "------------------------------------------------------------"

# ---------- Step 2. Create Resource Group ----------
# Syntax: az group create --name <name> --location <region>
az group create --name "$rgName" --location "$location" --output table

# ---------- Step 3. Check if Resource Group Exists ----------
echo ""
echo "Verifying Resource Group existence..."
exists=$(az group exists --name "$rgName")

if [ "$exists" = true ]; then
  echo "✅ Resource Group '$rgName' has been created successfully."
else
  echo "❌ Failed to create Resource Group '$rgName'."
  exit 1
fi

# ---------- Step 4. List All Resource Groups ----------
echo ""
echo "Listing all Resource Groups in your subscription:"
az group list --output table

# ---------- Step 5. Optional Cleanup ----------
# Uncomment to delete the Resource Group automatically after testing
# echo "Deleting Resource Group '$rgName'..."
# az group delete --name "$rgName" --yes --no-wait
# echo "Resource Group deletion initiated."

: '
=========================================================
Explanation:

1. VARIABLES
   - rgName and location store reusable values.
   - You can change them before running the script to test different setups.

2. ECHO
   - Prints text to console for readability, like Write-Host in PowerShell.

3. AZ GROUP CREATE
   - Creates a new Azure Resource Group.
   - "--output table" shows a neat table view instead of JSON.
   - Azure CLI uses the pattern:
        az <noun> <verb> --parameters
     Example: az group create --name <group> --location <region>

4. VERIFICATION
   - az group exists --name <rg> returns "true" or "false".
   - This lets you add logic to confirm creation succeeded.

5. LISTING
   - az group list --output table shows all groups with name, location, and tags.

6. CLEANUP
   - Deleting a group removes all resources within it.
   - "--yes" auto-confirms deletion; "--no-wait" runs it asynchronously.

🧭 Key Takeaways
1. Azure CLI uses az group create for creating groups, and az group exists for boolean verification.
2. $() captures command output into variables.
3. if [ "$exists" = true ]; then ... fi is a standard Bash conditional pattern.
4. --output table gives human-friendly formatting for Cloud Shell or terminals.

RESULT:
This script provides a simple and repeatable way to create
and validate resource groups directly from Bash and Azure CLI.
=========================================================
'
