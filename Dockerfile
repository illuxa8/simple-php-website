FROM php:7.4-cli

WORKDIR /var/www/html

COPY . .

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8888"]
