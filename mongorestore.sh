#!/bin/bash

# Entfernt die bestehende Datenbank und importiert dann den Dump
docker compose exec -T database sh -c "mongosh --eval 'db.getSiblingDB(\"user\").dropDatabase()' && mongorestore --archive" < db.dump
