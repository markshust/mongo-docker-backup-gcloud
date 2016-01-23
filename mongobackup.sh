#!/bin/bash
MONGO_DB=dbname
MONGO_HOST=127.0.0.1
HOST_DIR=/home/YOURNAME
BACKUP_DIR=/mongobackup
BUCKET=gs://BUCKET_NAME
DATE=`date +%Y-%m-%d:%H:%M:%S`

/usr/bin/docker run --rm \
  -v $HOST_DIR/$BACKUP_DIR:$BACKUP_DIR \
  markoshust/mongoclient \
  mongodump --host $MONGO_HOST --db $MONGO_DB --out $BACKUP_DIR

sudo mkdir -p $HOST_DIR/$BACKUP_DIR/$MONGO_DB/$DATE
sudo mv $HOST_DIR/$BACKUP_DIR/$MONGO_DB/* $HOST_DIR/$BACKUP_DIR/$MONGO_DB/$DATE

$HOST_DIR/gsutil/gsutil rsync -r $HOST_DIR/$BACKUP_DIR $BUCKET

sudo /bin/rm -rf $HOST_DIR/$BACKUP_DIR
