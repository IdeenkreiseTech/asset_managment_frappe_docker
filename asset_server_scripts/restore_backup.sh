# Restore Backup
db_password=123
site_name=172.30.1.59
db_backup=20230913_171646-asset_localhost-database.sql.gz
cd ../
sudo docker cp backup/$db_backup $(sudo docker compose ps -q backend):/tmp
sudo docker compose exec backend bench --site $site_name restore /tmp/$db_backup --mariadb-root-password 123
sudo docker compose exec backend bench --site $site_name migrate
sudo docker compose restart backend