# Create Site and Install Application
db_password=123
admin_password=123
encryption_key=2XUoeMnQAg_Mj6_p5k3HYYJHnoM-VBiuoYLcUyJlm3k=
git_password=123
site_name=172.30.1.59
TAG=2.0.14
cd ../
sudo docker login ghcr.io -u IdeenkreiseTech -p $git_password
sudo docker ghcr.io/ideenkreisetech/nitta_note_app/nitta_note_app:$TAG
sudo docker compose -f compose.yaml -f overrides/compose.noproxy.yaml -f overrides/compose.mariadb.yaml -f overrides/compose.redis.yaml up -d
sudo docker compose exec backend bench new-site $site_name  --no-mariadb-socket --mariadb-root-password $db_password --admin-password $admin_password
sudo docker compose exec backend bench --site $site_name install-app asset_management
sudo docker compose exec backend bench --site $site_name set-config encryption_key $encryption_key
sudo docker compose exec backend bench --site $site_name enable-scheduler