@echo off
echo Starting Django with Production Settings...
echo.
echo This will run your Django app with the same settings as PythonAnywhere
echo.
echo Collecting static files...
python manage.py collectstatic --noinput --settings=backend.settings_local_production
echo.
echo Starting server...
python manage.py runserver --settings=backend.settings_local_production
pause
