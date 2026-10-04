FROM php:8.3-apache

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-venv python3-dev build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && a2enmod proxy proxy_http rewrite headers

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /tmp/requirements.txt

COPY . /var/www/html/

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www/html \
    && rm -rf /var/www/html/.git /var/www/html/venv

EXPOSE 80

CMD ["/var/www/html/start.sh"]
