#!/bin/bash

VOL_ID="vol-082def99090a8e202"
DESCRIPTION="\"'mail.ra-gas.de' Snapshot via Script\""
REGION="eu-central-1"
echo aws ec2 create-snapshot --volume-id $VOL_ID --description "$DESCRIPTION" --region $REGION

