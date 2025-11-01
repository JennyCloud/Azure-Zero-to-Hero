#!/bin/bash
# create-aci.sh — deploy a simple Azure Container Instance demo

RESOURCE_GROUP="MiniLabs-RG"
ACI_NAME="helloaci$RANDOM"
LOCATION="canadacentral"
IMAGE="mcr.microsoft.com/azuredocs/aci-helloworld"

echo "Creating container instance $ACI_NAME in $LOCATION ..."
az container create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$ACI_NAME" \
  --image "$IMAGE" \
  --cpu 1 \
  --memory 1 \
  --ports 80 \
  --dns-name-label "$ACI_NAME" \
  --location "$LOCATION" \
  --os-type Linux \
  --restart-policy Always \
  --output table

echo "Done! Checking status..."
az container show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$ACI_NAME" \
  --query "{State:instanceView.state,FQDN:ipAddress.fqdn}" \
  --output table
