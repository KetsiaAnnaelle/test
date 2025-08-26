# PythonAnywhere Deployment Guide

## Step 1: Prepare Your Local Project

1. **Update your local settings for production:**
   ```bash
   # Make sure DEBUG = False in settings.py
   # Add your PythonAnywhere domain to ALLOWED_HOSTS
   ```

2. **Collect static files locally:**
   ```bash
   python manage.py collectstatic
   ```

3. **Commit and push to GitHub:**
   ```bash
   git add .
   git commit -m "Prepare for PythonAnywhere deployment"
   git push origin main
   ```

## Step 2: PythonAnywhere Setup

### 2.1 Clone Your Repository
```bash
# In PythonAnywhere console
cd ~
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name/backend
```

### 2.2 Install Dependencies
```bash
pip install -r requirements_production.txt
```

### 2.3 Database Setup
```bash
python manage.py migrate
python manage.py createsuperuser  # Create admin user
```

### 2.4 Collect Static Files
```bash
python manage.py collectstatic --noinput
```

## Step 3: Configure Web App

### 3.1 Go to Web Tab
- Click on "Web" tab in PythonAnywhere dashboard
- Click "Add a new web app"
- Choose "Manual configuration"
- Choose Python version (3.11 or 3.12)

### 3.2 Configure WSGI File
Edit the WSGI file and replace the content with:

```python
import os
import sys

# Add your project directory to the sys.path
path = '/home/yourusername/your-repo-name/backend'
if path not in sys.path:
    sys.path.append(path)

# Set environment variable
os.environ['DJANGO_SETTINGS_MODULE'] = 'backend.settings'

# Import Django WSGI application
from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()
```

### 3.3 Configure Virtual Environment
- Go to "Virtual environment" section
- Enter: `/home/yourusername/your-repo-name/backend`

### 3.4 Configure Static Files
- Go to "Static files" section
- Add:
  - URL: `/static/`
  - Directory: `/home/yourusername/your-repo-name/backend/staticfiles`
- Add:
  - URL: `/media/`
  - Directory: `/home/yourusername/your-repo-name/backend/media`

## Step 4: Environment Variables

### 4.1 Create .env file
```bash
# In your project directory
nano .env
```

Add your environment variables:
```
SECRET_KEY=your-secret-key-here
DEBUG=False
```

### 4.2 Update settings.py to use environment variables
```python
from dotenv import load_dotenv
load_dotenv()

SECRET_KEY = os.getenv('SECRET_KEY', 'your-default-secret-key')
DEBUG = os.getenv('DEBUG', 'False').lower() == 'true'
```

## Step 5: Reload Web App

1. Go back to "Web" tab
2. Click "Reload" button
3. Check the error logs if there are issues

## Step 6: Test Your Application

1. Visit your PythonAnywhere domain
2. Test all functionality:
   - Dashboard login
   - Adding/editing items
   - File uploads
   - Static files loading

## Common Issues and Solutions

### Issue 1: Static Files Not Loading
**Solution:**
- Make sure static files are collected: `python manage.py collectstatic`
- Check static files configuration in Web app settings
- Verify STATIC_ROOT path is correct

### Issue 2: Media Files Not Uploading
**Solution:**
- Check media directory permissions
- Ensure MEDIA_ROOT is properly configured
- Add media files configuration in Web app settings

### Issue 3: Database Errors
**Solution:**
- Run migrations: `python manage.py migrate`
- Check database file permissions
- Ensure database path is correct

### Issue 4: Import Errors
**Solution:**
- Check virtual environment is activated
- Verify all dependencies are installed
- Check Python path in WSGI file

### Issue 5: 500 Server Error
**Solution:**
- Check error logs in Web tab
- Verify DEBUG = False in production
- Check ALLOWED_HOSTS includes your domain

## Security Checklist

- [ ] DEBUG = False in production
- [ ] SECRET_KEY is properly set
- [ ] ALLOWED_HOSTS includes your domain
- [ ] CSRF_TRUSTED_ORIGINS includes your domain
- [ ] Static files are properly configured
- [ ] Database is properly secured

## Performance Tips

1. **Enable compression** in Web app settings
2. **Use CDN** for static files if needed
3. **Optimize images** before uploading
4. **Enable caching** for better performance

## Monitoring

- Check error logs regularly
- Monitor disk space usage
- Check CPU usage
- Monitor database performance




