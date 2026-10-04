#!/bin/bash
set -e

cd /var/www/html

# Railway supplies PORT for the public web server. Flask stays internal on 5000.
PORT="${PORT:-80}"
sed -i "s/^Listen 80$/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s#<VirtualHost \*:80>#<VirtualHost *:${PORT}>#" /etc/apache2/sites-available/000-default.conf

# Start Flask internally; Apache exposes its /api routes on the public port.
/opt/venv/bin/python app.py &

exec apache2-foreground
