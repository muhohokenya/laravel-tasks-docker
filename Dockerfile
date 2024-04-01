# Use the official PHP 8.1 image as base
FROM php:8.1-apache

# Set working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo_mysql zip \
    && a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction

# Set permissions for the vendor directory
RUN chmod -R 755 vendor

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Copy script to generate application key
COPY generate_key.sh /usr/local/bin/generate_key.sh

# Set execute permissions on the script
RUN chmod +x /usr/local/bin/generate_key.sh

# Expose port 80
EXPOSE 80

# Start Apache and generate application key
CMD ["sh", "-c", "generate_key.sh && apache2-foreground"]
