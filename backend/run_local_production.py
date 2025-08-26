#!/usr/bin/env python
"""
Script to run Django server with production settings locally
This mimics the PythonAnywhere environment for testing
"""

import os
import sys
import django
from django.core.management import execute_from_command_line

def main():
    """Run Django with production settings"""
    
    # Set Django settings module to production settings
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'backend.settings_local_production')
    
    # Set environment variables for production testing
    os.environ['DEBUG'] = 'False'
    os.environ['SECRET_KEY'] = 'django-insecure-iw1xcrpq5&ok=fcic9g6c)*06i=r)uhz47liil24tg!ku-@!d)'
    
    # Setup Django
    django.setup()
    
    # Run the server
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()




