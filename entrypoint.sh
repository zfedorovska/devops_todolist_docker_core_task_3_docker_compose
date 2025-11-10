set -e

echo "Waiting for database at ${DB_HOST:-db}:3306..."

while ! nc -z "${DB_HOST:-db}" 3306; do
  sleep 1
done

echo "Database is up! Running migrations..."
python manage.py migrate

echo "Starting Django development server..."
python manage.py runserver 0.0.0.0:8080
