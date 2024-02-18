gcloud compute resource-policies create instance-schedule mageai-start-stop \
    [--description='SCHEDULE_DESCRIPTION'] \
    [--region='asia-southeast2-b'] \
    [--vm-start-schedule='0 20 * * *'] \
    [--vm-stop-schedule='0 22 * * *'] \
    [--timezone='Asia/Jakarta'] \
    [--initiation-date='2024-02-18T00:00:00.000Z'] \

gcloud compute instances add-resource-policies VM_NAME \
    --resource-policies=mageai-start-stop \
    [--zone='asia-southeast2']