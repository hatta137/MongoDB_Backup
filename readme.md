# Anleitung: MongoDB Backup und Restore (mit Docker - Host-System: macOS)

1. docker-compose.yml erstellen mit folgenden Daten:
```yml
services:
  database:
    image: mongo:latest
    container_name: database
    ports:
      - "27017:27017"
    command: mongod --logpath /var/log/mongodb/mongod.log --logappend --quiet --setParameter logLevel=2 # Log-Meldungen auf Fehler
    volumes:
      - ./database:/data/db
    networks:
      - private


networks:
  private:
    driver: bridge

```
2. docker-compose.yml starten mit folgenden Befehl:
```bash
docker-compose up -d
```
3. Testdaten importieren, beispielsweise über MongoDB Compass
4. Auf den Container verbinden mit folgendem Befehl:
```bash
docker exec -it database bash
```
5. MongoDump Script bauen:
```bash
docker compose exec -T database sh -c 'mongodump --archive' > db.dump
```
6. Restore Script bauen:
```bash
# Entfernt die bestehende Datenbank und importiert dann den Dump
docker compose exec -T database sh -c "mongosh --eval 'db.getSiblingDB(\"user\").dropDatabase()' && mongorestore --archive" < db.dump
```
7. Scripte ausführbar machen:
```bash
chmod +x mongodump.sh && chmod +x mongorestore.sh
```
8. Scripte nach Bedarf ausführen:
```bash
./mongodump.sh

./mongorestore.sh
```

