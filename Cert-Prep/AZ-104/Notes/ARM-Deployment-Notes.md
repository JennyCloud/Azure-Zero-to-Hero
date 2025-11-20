# ARM Deployment Notes

## Inline Array Parameters
Pass arrays inline using `--parameters`:

az deployment group create \
  --resource-group RG1 \
  --template-file main.json \
  --parameters subnetPrefixes="['10.0.1.0/24','10.0.2.0/24']"

PowerShell:
New-AzResourceGroupDeployment `
  -ResourceGroupName RG1 `
  -TemplateFile main.json `
  -TemplateParameterObject @{ subnetPrefixes = @("10.0.1.0/24","10.0.2.0/24") }

## Inline Object Parameters (CLI)

Objects must be valid JSON strings:
--parameters vmSettings="{\"size\":\"Standard_B2s\"}"

## Parameter Precedence

Inline parameters override parameters from a file:
--parameters @params.json --parameters environment="Prod"

Result: Prod is used.

## Boolean Type Coercion

CLI coerces "true" into boolean true:

--parameters enableLogging="true"

Deployment succeeds with enableLogging = true.

## secureString Behavior

Passing a secureString inline:
--parameters adminPassword="P@ssw0rd123!"
ARM stores the value securely and masks it in deployment history.

## Nested Template Parameter Passing

Parent template forwarding a parameter:
"parameters": {
  "vmName": {
    "value": "[parameters('vmName')]"
  }
}
CLI deployment:
--parameters vmName=myVM
Nested template receives: myVM.

## Nested Parameter Precedence

If you pass:
--parameters vmSize="Standard_E2s_v3"
Nested template receives this value, overriding its own default.

## Deployment Name Collisions

Reusing a deployment name:
--name MainDeploy
The new deployment overwrites the existing deployment record.

## Incremental vs Complete Mode

Complete mode deletes resources not listed in the template:
--mode Complete
Example:

Template contains: VNet1, SubnetA

Resource group contains: VNet1, SubnetA, NSG1, PublicIP1

Result: NSG1 and PublicIP1 are deleted.
