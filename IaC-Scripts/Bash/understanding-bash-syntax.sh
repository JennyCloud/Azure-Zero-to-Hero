#!/bin/bash
# =========================================
# File: understanding-bash-syntax.sh
# Purpose: Introduce Bash syntax and Azure CLI (az) command structure
# =========================================

# ---------- Step 1. Variables ----------
# Variables store reusable values. No $ when declaring; use $ when reading.
rgName="SyntaxDemo-RG"
location="canadacentral"

# ---------- Step 2. Comments ----------
# Lines starting with # are comments and won't be executed.

# ---------- Step 3. Echo ----------
# 'echo' prints messages to the console (similar to Write-Host in PowerShell)
echo "Creating Resource Group: $rgName in $location"

# ---------- Step 4. Command Execution ----------
# Azure CLI command: az <noun> <verb> --parameters
# Example: az group create --name <name> --location <region>
az group create --name "$rgName" --location "$location"

# ---------- Step 5. Conditional Execution ----------
# You can check whether a command succeeded using if / then / fi
if [ $? -eq 0 ]; then
  echo "Resource group created successfully."
else
  echo "Resource group creation failed."
fi

# ---------- Step 6. Listing Resources ----------
echo "Listing all resource groups in your subscription..."
az group list --output table

# ---------- Step 7. Clean Up (optional) ----------
# Uncomment the next line if you want to delete the test group
# az group delete --name "$rgName" --yes --no-wait

: '
=========================================================
Explanation:

1. SHEBANG
   - The first line #!/bin/bash tells Linux or Cloud Shell to use the Bash interpreter.

2. VARIABLES
   - Syntax: name=value (no spaces).
   - Use "$name" to read its value.
     Example: echo "Hello $username"

3. COMMENTS
   - Start with # for single lines.
   - Use : ' ... ' for multiline comments (like this block).

4. ECHO
   - Displays output on the screen.
   - Useful for progress messages or debugging.

5. AZURE CLI COMMANDS
   - Structure: az <resource> <action> [--flags]
   - Example: az vm create --name MyVM --image UbuntuLTS
   - Use --output table/json/yaml to change output format.

6. CONDITIONALS
   - $? holds the exit code of the last command (0 = success).
   - if [ $? -eq 0 ]; then ... fi checks whether the previous command succeeded.

7. CLEANUP
   - az group delete removes the resource group.
   - --yes bypasses confirmation; --no-wait runs it asynchronously.

RESULT:
This script demonstrates the core Bash and Azure CLI patterns
you'll use in all automation scripts that follow.
=========================================================
'
