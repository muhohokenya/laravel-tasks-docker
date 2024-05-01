#!/bin/bash

# Install software-properties-common to manage the repositories
sudo apt-get install -y software-properties-common
# Add PHP repository
sudo add-apt-repository ppa:ondrej/php -y

# Install MySQL client
sudo apt-get install -y mysql-client-core-8.0

# Install PHP 8.2 with required extensions
sudo apt-get install -y php8.2-fpm php8.2 php8.2-cli php8.2-pdo php8.2-mysql php8.2-zip git unzip curl php8.2-xml php8.2-curl


sudo systemctl start php8.2-fpm
sudo systemctl enable php8.2-fpm

# Change ownership of the web directory
sudo chown -R www-data:www-data /var/www/html

# Set the working directory to the web root
# shellcheck disable=SC2164
cd /var/www/html/

# Remove default index.html



# Set proper permissions for directories
sudo chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
sudo chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

