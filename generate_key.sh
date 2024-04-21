#!/bin/bash

#php artisan key:generate &&

php artisan migrate
# Check if the .env file exists
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Generate application key if it doesn't exist
if ! grep -q "APP_KEY=" .env; then
    php artisan key:generate
fi
