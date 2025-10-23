Requesting a Cloud Shell.Succeeded. 
Connecting terminal...

Welcome to Azure Cloud Shell

Type "az" to use Azure CLI
Type "help" to learn about Cloud Shell


MOTD: SqlServer has been updated to Version 22!

VERBOSE: Authenticating to Azure ...
VERBOSE: Building your Azure drive ...
PS /home/jenny> az group create --name RG-Test-Bastion-Central --location centralus                                                                                                
{
  "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central",
  "location": "centralus",
  "managedBy": null,
  "name": "RG-Test-Bastion-Central",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
PS /home/jenny> az vm create `                                                                                                                                                     
>>   --resource-group RG-Test-Bastion-Central `
>>   --name TestVM `
>>   --image Win2019Datacenter `
>>   --admin-username azureuser `
>>   --admin-password "Wmt828719!12" `
>>   --size Standard_B2s `
>>   --vnet-name TestVMVNet `
>>   --subnet default `
>>   --public-ip-sku Standard
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
{
  "fqdns": "",
  "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Compute/virtualMachines/TestVM",
  "location": "centralus",
  "macAddress": "7C-ED-8D-09-25-8C",
  "powerState": "VM running",
  "privateIpAddress": "10.0.0.4",
  "publicIpAddress": "172.202.32.129",
  "resourceGroup": "RG-Test-Bastion-Central"
}
PS /home/jenny> az vm show `                                                                                                                                                       
>>   --resource-group RG-Test-Bastion-Central `
>>   --name TestVM `
>>   --query "networkProfile.networkInterfaces[0].id" `
>>   -o tsv
/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/networkInterfaces/TestVMVMNic
PS /home/jenny> az network nic show `                                                                                                                                              
>>   --resource-group RG-Test-Bastion-Central `
>>   --name TestVMVMNic `
>>   --query "ipConfigurations[0].subnet.id" `
>>   -o tsv
/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/virtualNetworks/TestVMVNet/subnets/default
PS /home/jenny> az network vnet subnet create `                                                                                                                                    
>>   --resource-group RG-Test-Bastion-Central `
>>   --vnet-name TestVMVNet `
>>   --name AzureBastionSubnet `
>>   --address-prefix 10.0.1.0/27
{
  "addressPrefix": "10.0.1.0/27",
  "delegations": [],
  "etag": "W/\"60a3e649-7e51-4b55-bbe8-9a125ca8c442\"",
  "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/virtualNetworks/TestVMVNet/subnets/AzureBastionSubnet",
  "name": "AzureBastionSubnet",
  "privateEndpointNetworkPolicies": "Disabled",
  "privateLinkServiceNetworkPolicies": "Enabled",
  "provisioningState": "Succeeded",
  "resourceGroup": "RG-Test-Bastion-Central",
  "type": "Microsoft.Network/virtualNetworks/subnets"
}
PS /home/jenny> az network public-ip create `                                                                                                                                      
>>   --resource-group RG-Test-Bastion-Central `
>>   --name BastionPublicIP `
>>   --sku Standard
[Coming breaking change] In the coming release, the default behavior will be changed as follows when sku is Standard and zone is not provided: For zonal regions, you will get a zone-redundant IP indicated by zones:["1","2","3"]; For non-zonal regions, you will get a non zone-redundant IP indicated by zones:null.
{
  "publicIp": {
    "ddosSettings": {
      "protectionMode": "VirtualNetworkInherited"
    },
    "etag": "W/\"87967bf7-55ce-4a47-9eb9-af18d5ab6315\"",
    "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/publicIPAddresses/BastionPublicIP",
    "idleTimeoutInMinutes": 4,
    "ipAddress": "52.173.207.243",
    "ipTags": [],
    "location": "centralus",
    "name": "BastionPublicIP",
    "provisioningState": "Succeeded",
    "publicIPAddressVersion": "IPv4",
    "publicIPAllocationMethod": "Static",
    "resourceGroup": "RG-Test-Bastion-Central",
    "resourceGuid": "bb4b394c-1483-4866-9f3c-57445243ce2f",
    "sku": {
      "name": "Standard",
      "tier": "Regional"
    },
    "type": "Microsoft.Network/publicIPAddresses"
  }
}
PS /home/jenny> 
PS /home/jenny> az network bastion create `
>>   --name BastionHost `
>>   --resource-group RG-Test-Bastion-Central `
>>   --vnet-name TestVMVNet `
>>   --subnet AzureBastionSubnet `
>>   --public-ip-address BastionPublicIP `
>>   --location centralus
Preview version of extension is disabled by default for extension installation, enabled for modules without stable versions. 
Please run 'az config set extension.dynamic_install_allow_preview=true or false' to config it specifically. 
The command requires the extension bastion. Do you want to install it now? The command will continue to run after the extension is installed. (Y/n): Y
Run 'az config set extension.use_dynamic_install=yes_without_prompt' to allow installing extensions without prompt.
unrecognized arguments: --subnet AzureBastionSubnet

Examples from AI knowledge base:
az network bastion create --location westus2 --name MyBastionHost --public-ip-address MyPublicIpAddress --resource-group MyResourceGroup --vnet-name MyVnet
Create a Azure bastion host machine. (autogenerated)

https://docs.microsoft.com/en-US/cli/azure/network/bastion#az_network_bastion_create
Read more about the command in reference docs
PS /home/jenny> az network bastion create `                                                                                                                                        
>>   --name BastionHost `
>>   --resource-group RG-Test-Bastion-Central `
>>   --vnet-name TestVMVNet `
>>   --public-ip-address BastionPublicIP `
>>   --location centralus
{
  "disableCopyPaste": false,
  "dnsName": "bst-c6d0e241-1c81-4315-8640-7f8935eac67d.bastion.azure.com",
  "enableFileCopy": false,
  "enableIpConnect": false,
  "enableKerberos": false,
  "enableSessionRecording": false,
  "enableShareableLink": false,
  "enableTunneling": false,
  "etag": "W/\"9fdfced8-29d8-45e7-b155-1efe64e8aa40\"",
  "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/bastionHosts/BastionHost",
  "ipConfigurations": [
    {
      "etag": "W/\"9fdfced8-29d8-45e7-b155-1efe64e8aa40\"",
      "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/bastionHosts/BastionHost/bastionHostIpConfigurations/bastion_ip_config",
      "name": "bastion_ip_config",
      "privateIPAllocationMethod": "Dynamic",
      "provisioningState": "Succeeded",
      "publicIPAddress": {
        "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/publicIPAddresses/BastionPublicIP",
        "resourceGroup": "RG-Test-Bastion-Central"
      },
      "resourceGroup": "RG-Test-Bastion-Central",
      "subnet": {
        "id": "/subscriptions/e3463a54-343e-4abe-a279-a276f256ed67/resourceGroups/RG-Test-Bastion-Central/providers/Microsoft.Network/virtualNetworks/TestVMVNet/subnets/AzureBastionSubnet",
        "resourceGroup": "RG-Test-Bastion-Central"
      },
      "type": "Microsoft.Network/bastionHosts/bastionHostIpConfigurations"
    }
  ],
  "location": "centralus",
  "name": "BastionHost",
  "provisioningState": "Succeeded",
  "resourceGroup": "RG-Test-Bastion-Central",
  "scaleUnits": 2,
  "sku": {
    "name": "Standard"
  },
  "tags": {},
  "type": "Microsoft.Network/bastionHosts"
}
PS /home/jenny> 
