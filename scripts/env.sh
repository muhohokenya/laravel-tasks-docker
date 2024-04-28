# Update the package list
sudo apt-get update
sudo apt-get upgrade -y

sudo apt install ruby-full -y

sudo apt install wget

cd /home/ubuntu

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto

systemctl status codedeploy-agent

# Install software-properties-common to manage the repositories
sudo apt-get install -y software-properties-common
# Add PHP repository
sudo add-apt-repository ppa:ondrej/php -y

# Install MySQL client
sudo apt-get install -y mysql-client-core-8.0

# Install Nginx and PHP 8.1 with required extensions
sudo apt-get install -y nginx php8.1-fpm php8.1 php8.1-cli php8.1-pdo php8.1-mysql php8.1-zip git unzip curl php8.1-xml php8.1-curl

# Start and enable Nginx and PHP-FPM
sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl start php8.1-fpm
sudo systemctl enable php8.1-fpm

# Change ownership of the web directory
sudo chown -R www-data:www-data /var/www/html

# Install Composer globally
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# Set proper permissions for directories
sudo chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
sudo chmod -R 777 /var/www/html/storage /var/www/html/bootstrap/cache
