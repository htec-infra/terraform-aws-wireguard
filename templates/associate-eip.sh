#!/bin/bash

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Get volumeId
EIP_ID=$(aws ec2 describe-addresses \
  --region "$REGION" \
  --filters "Name=tag:HandlerId,Values=${ADDR_HANDLER_ID}" \
  --query Addresses[].AllocationId \
  --output text)

if [[ -n $EIP_ID ]]; then
  aws ec2 associate-address --instance-id "$INSTANCE_ID" --allocation-id "$EIP_ID" --region "$REGION"
  echo ">>> ElasticIP associated!"
else
  echo ">>> ElasticIP doesn't exist!"
fi
