composer install && php -r "file_exists('.env') || copy('.env.example', '.env');" && php artisan key:generate --ansi

echo 'Waiting for database to accept connections...'
attempt=1;
maxAttempts=5;
sleepTime=5;
until php artisan tinker --execute 'try { DB::statement("select true"); echo("DB ready"); } catch (Throwable $e) { exit(1); }' | grep -q "DB ready" || [ $attempt -eq $maxAttempts ]; do
    echo "Attempt $attempt failed, retrying in ${sleepTime}s...";
    ((attempt=attempt+1));
    sleep $sleepTime;
done

if [ "$attempt" -eq "$maxAttempts" ]; then
    echo "Could not connect to database after $attempt attempts! Aborting...";
    exit 1;
fi

echo "Database ready!"
echo 'php artisan migrate'
php artisan migrate
echo '';

echo 'npm install '
npm install
echo 'npm run build'
npm run build
