#!/bin/bash
# Save this as: bash/01-create-database.sh

# --- CONFIGURATION ---
RDS_ENDPOINT="serpent-db.c1yqesg669dd.eu-central-1.rds.amazonaws.com"
DB_NAME="serpent_surge_db"
DB_USER="admin"
DB_PASS="adminpassword"

# --- EXECUTE SQL ---
echo "Connecting to RDS and creating table..."

mysql -h "$RDS_ENDPOINT" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
CREATE TABLE scores (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(3) NOT NULL,
  difficulty INT NOT NULL,
  score INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO score VALUES (1, 'Zoltán', 9999, 3)
  ON DUPLICATE KEY UPDATE name=VALUES(name), score=VALUES(score), difficulty=VALUES(difficulty);

SELECT * FROM score;
EOF

# --- RESULT ---
echo "✅ Table created and test row inserted."

