#!/bin/bash

# shellcheck disable=SC2154
#echo "DB_HOST=${db_endpoint}"
DB_HOST="terraform-20240428233826606300000003.cjr4qbxdh5o6.us-east-1.rds.amazonaws.com"
sed -i "s/^DB_HOST=.*/DB_HOST=$DB_HOST/" .env
sed -i "s/^DB_DATABASE=.*/DB_DATABASE=tasks/" .env
sed -i "s/^DB_USERNAME=.*/DB_USERNAME=laravel_user/" .env
sed -i "s/^DB_PASSWORD=.*/DB_PASSWORD=gitpass2016/" .env
php artisan migrate
php artisan db:seed

# Generate application key if it doesn't exist
if ! grep -q "APP_KEY=" .env; then
    php artisan key:generate
fi
# Output a success message
echo "Nginx and PHP setup completed. Verify by accessing your server's IP."
