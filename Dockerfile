# Use the official Python image from the Docker Hub
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install the dependencies
RUN pip install -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY . .

# Set the environment variable for MongoDB URI
ENV MONGODB_URI=mongodb://mongodb:27017/

# Command to run the Flask application
CMD ["python", "app.py"]
