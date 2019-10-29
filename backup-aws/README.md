


## Informationen Instanzen

```bash
aws ec2 describe-instances --output table
```


## Snapshot via Script

```bash
VOL_ID="vol-0838dde7f5808b41c"
DESCRIPTION="Test Snapshot via Script"
REGION="eu-central-1b"
aws ec2 create-snapshot --volume-id $VOL_ID --description "$DESCRIPTION" --region $REGION
```

