#!/bin/sh
PROJECT=nyc-cabfare
BUCKET=nyc_cab
REGION=us-east1


#rm -rf ./taxi_trained
export PYTHONPATH=${PYTHONPATH}:${PWD}/nyc_cab_tree
python -m tree_trainer.task --train_data_paths=gs://${BUCKET}/nyc_data/nyc_train*001 \
                            --eval_data_paths=gs://${BUCKET}/nyc_data/nyc_valid*001 \
                            --output_dir=./taxi_trained_tree \
                            --train_steps=5000 \
                            --job-dir=./tmp \
                            #--hidden_units="1000 500 100"
