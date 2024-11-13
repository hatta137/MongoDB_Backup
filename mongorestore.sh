#!/bin/bash
DB_CONTAINER="database"
DB_NAME="user"
DB_PATH="db.dump"

# Entfernt die bestehende Datenbank und importiert dann den Dump
docker compose exec -T $DB_CONTAINER sh -c "mongosh --eval 'db.getSiblingDB(\"$DB_DB_NAME\").dropDatabase()' && mongorestore --archive" < "$DB_PATH"
