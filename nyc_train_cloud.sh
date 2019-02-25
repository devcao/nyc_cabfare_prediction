PROJECT=nyc-cabfare
BUCKET=nyc_cab
REGION=us-east1

echo $PROJECT
echo $BUCKET
echo $REGION

OUTDIR=gs://${BUCKET}/taxi_trained_new
JOBNAME=train_taxi_v1$(date -u +%y%m%d_%H%M%S)
echo $OUTDIR $REGION $JOBNAME

#gsutil -m rm -rf $OUTDIR #trainsteps: more than 500,000

gcloud ml-engine jobs submit training $JOBNAME \
  --region=$REGION \
  --module-name=trainer.task \
  --package-path=${PWD}/nyc_cab_model/trainer \
  --job-dir=$OUTDIR \
  --staging-bucket=gs://$BUCKET \
  --scale-tier=BASIC_GPU \
  --runtime-version=1.8 \
  -- \
  --train_data_paths=gs://${BUCKET}/nyc_data/nyc_train* \
  --eval_data_paths=gs://${BUCKET}/nyc_data/nyc_valid*  \
  --train_steps=500000 \
  --output_dir=$OUTDIR \
  --train_batch_size=128 \
  --eval_batch_size=128 \
  --hidden_unit="1000 500 100 8"



