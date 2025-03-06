# Use a stable Python version
FROM python:3.11-slim  

# Set the working directory inside the container
WORKDIR /app  

# Install necessary system dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-setuptools  

# Install Django and other dependencies
RUN pip install --no-cache-dir django==3.2  

# Copy the application code AFTER installing dependencies (better caching)
COPY . .

# Run Django migrations
RUN python manage.py migrate || echo "Migration failed but continuing..."  

# Expose the Django default port
EXPOSE 8000  

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

