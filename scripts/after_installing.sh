#!/bin/bash

# Install software-properties-common to manage the repositories
sudo apt-get install -y software-properties-common
# Add PHP repository
sudo add-apt-repository ppa:ondrej/php -y

# Install MySQL client
sudo apt-get install -y mysql-client-core-8.0

# Install Nginx and PHP 8.1 with required extensions
sudo apt-get install -y nginx php8.2-fpm php8.2 php8.2-cli php8.2-pdo php8.2-mysql php8.2-zip git unzip curl php8.2-xml php8.2-curl

# Start and enable Nginx and PHP-FPM
sudo systemctl start nginx
sudo systemctl enable nginx
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
sudo test -f /etc/nginx/sites-available/laravel.conf && sudo rm -f /etc/nginx/sites-available/laravel.conf
# Configure Nginx server block
cat <<EOF | sudo tee /etc/nginx/sites-available/laravel.conf
server {
    listen 80;
    listen [::]:80;
    server_name test.com;
    root /var/www/html/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;
    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico {
        access_log off;
        log_not_found off;
    }

    location = /robots.txt {
        access_log off;
        log_not_found off;
    }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}

EOF
sudo unlink /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default

sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

# Enable the new site and reload Nginx
sudo ln -s /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/

sudo systemctl reload nginx
