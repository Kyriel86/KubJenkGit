# Use an appropriate base image with Python and pip
# You can consider using a more recent Python version, if desired
FROM python:3.8-slim-buster

# Set the working directory within the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . .

# Specify the command to run the Flask application
CMD ["python", "app.py"]
