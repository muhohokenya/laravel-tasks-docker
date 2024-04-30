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
sudo systemctl start php8.1-fpm
sudo systemctl enable php8.1-fpm

# Change ownership of the web directory
sudo chown -R www-data:www-data /var/www/html

# Set the working directory to the web root
# shellcheck disable=SC2164
cd /var/www/html/

# Remove default index.html
sudo rm -f /var/www/html/index.nginx-debian.html

# Install Composer globally
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer


# Set proper permissions for directories
sudo chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
sudo chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache

# Configure Nginx server block
cat <<EOF | sudo tee /etc/nginx/sites-available/laravel.conf
server {
    listen 80;
    server_name _;
    root /var/www/html/public;

    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log /var/log/nginx/laravel_error.log;
    access_log /var/log/nginx/laravel_access.log;
}

EOF
#sudo unlink /etc/nginx/sites-enabled/default
#sudo rm /etc/nginx/sites-available/default

sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

# Enable the new site and reload Nginx
#sudo ln -s /etc/nginx/sites-available/laravel.conf /etc/nginx/sites-enabled/

sudo systemctl reload nginx

# Check if .env file exists, copy from example if not
#if [ ! -f .env ]; then
#    cp .env.example .env
#fi
