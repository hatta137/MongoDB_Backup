#!/bin/bash
DB_CONTAINER="database"
DB_PATH="db.dump"

docker compose exec -T $DB_CONTAINER sh -c 'mongodump --archive' > DB_PATH