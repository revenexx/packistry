touch /data/database.sqlite
ln -sf /data/database.sqlite /var/www/html/database/database.sqlite

mkdir -p /data/archives
mkdir -p /var/www/html/storage/app
ln -sf /data/archives /var/www/html/storage/app/private

envsubst < /etc/supervisord.tpl > ~/supervisord.conf

php artisan config:cache
php artisan event:cache
php artisan route:cache
php artisan migrate --force

/usr/bin/supervisord -c ~/supervisord.conf
