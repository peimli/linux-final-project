#!/bin/bash


RDS_ENDPOINT="serpent-db.c1yqesg669dd.eu-central-1.rds.amazonaws.com"
DB_NAME="serpent_surge_db"
DB_USER="admin"
DB_PASS="adminpassword"
S3_BUCKET="serpent-surge-backups-264bd454"
BACKUP_DIR="/opt/backups"
LOG_FILE="/var/log/score-backup.log"
DATE=$(date +"%Y%m%d-%H%M%S")
FILENAME="score-${DATE}.sql"

# --- ENSURE BACKUP DIRECTORY EXISTS ---
sudo mkdir -p "$BACKUP_DIR"
sudo chown $(whoami) "$BACKUP_DIR"

# --- DUMP DATABASE ---
echo "[$(date)] Dumping score table..." | tee -a "$LOG_FILE"
mysqldump -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" score > "$BACKUP_DIR/$FILENAME"

# --- UPLOAD TO S3 ---
echo "[$(date)] Uploading $FILENAME to S3 bucket $S3_BUCKET..." | tee -a "$LOG_FILE"
aws s3 cp "$BACKUP_DIR/$FILENAME" "s3://$S3_BUCKET/$FILENAME"

# --- KEEP ONLY LATEST 3 LOCAL BACKUPS ---
echo "[$(date)] Rotating backups..." | tee -a "$LOG_FILE"
cd "$BACKUP_DIR"
ls -1t score-*.sql | tail -n +4 | xargs -r rm -v | tee -a "$LOG_FILE"

# --- DONE ---
echo "[$(date)] ✅ Backup completed for $FILENAME" | tee -a "$LOG_FILE"

