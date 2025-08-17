# PowerShell script to run Django with production settings locally

Write-Host "Starting Django with Production Settings..." -ForegroundColor Green
Write-Host ""
Write-Host "This will run your Django app with the same settings as PythonAnywhere" -ForegroundColor Yellow
Write-Host ""

# Collect static files
Write-Host "Collecting static files..." -ForegroundColor Cyan
python manage.py collectstatic --noinput --settings=backend.settings_local_production

Write-Host ""
Write-Host "Starting server..." -ForegroundColor Cyan
python manage.py runserver --settings=backend.settings_local_production
