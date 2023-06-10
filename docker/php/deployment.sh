#!/bin/sh
php -r "file_exists('.env') || copy('.env.example', '.env');" && php artisan key:generate --ansi

echo "Environment set to ${ENVIRONMENT}"
if [ "${ENVIRONMENT}" = "production" ]; then
  echo "Apply env from production!"
  mv .env.production .env
fi

echo "Cleanup cache"
rm -f /var/www/html/bootstrap/cache/config.php || exit 1
rm -f /var/www/html/bootstrap/cache/packages.php  || exit 1
mkdir -p -- /var/www/html/storage/framework/cache/data /var/www/html/storage/framework/sessions /var/www/html/storage/framework/views /var/www/html/storage/logs /var/www/html/storage/app

echo "Closing site..."
php /var/www/html/artisan down

echo "Clearing cache..."
php /var/www/html/artisan cache:clear

echo "Clearing config..."
php /var/www/html/artisan config:clear

echo "Clearing routes..."
php /var/www/html/artisan route:clear

echo "Cleanup cache"
rm -f /var/www/html/bootstrap/cache/config.php || exit 1
rm -f /var/www/html/bootstrap/cache/packages.php  || exit 1

echo "Running migrations..."
php /var/www/html/artisan migrate --force

echo "Clearing cache..."
php /var/www/html/artisan cache:clear

echo "Clean views..."
php /var/www/html/artisan view:clear

echo "Clearing cache..."
php /var/www/html/artisan cache:clear

echo "Caching config..."
php /var/www/html/artisan config:cache

echo "Clearing routes..."
php /var/www/html/artisan route:clear

echo "Caching routes..."
php /var/www/html/artisan route:cache

if [ "${ENVIRONMENT}" = "production" ]; then
  echo "Preserving rights"
  find /var/www -not -path "*/node_modules*" -type f -exec chmod 664 {} +
  find /var/www -not -path "*/node_modules*" -type f -name "*.php" -exec chmod 660 {} +
  find /var/www -not -path "*/node_modules*" -type f -name "*.sh" -exec chmod 770 {} +

  #chmod +x /var/www/html/vendor/laravel/dusk/bin/chromedriver-linux

  chown -R www-data:www-data /var/www/html
  chmod -R g+rw /var/www/html
fi

echo "Opening testing site..."
php /var/www/html/artisan up

echo "Deployment done."
touch /var/www/html/.setup_complete

exec "$@"

fi
