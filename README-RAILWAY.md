# SeniorConnect — Railway deployment notes

This copy is prepared for a Railway deployment using:

- One Railway web service (PHP/Apache + internal Flask API)
- One Railway MySQL service
- Apache reverse proxy from `/api/*` to the internal Flask server on port 5000

Do not commit `.env`. Configure these variables in Railway:

- `SECRET_KEY`
- `JWT_SECRET_KEY`
- `DB_HOST`
- `DB_PORT`
- `DB_USER`
- `DB_PASSWORD`
- `DB_NAME`

The browser uses same-origin `/api` URLs. PHP's server-side calls use `127.0.0.1:5000` because PHP and Flask run in the same container.
