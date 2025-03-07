# Use an official Python runtime
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the entire project to the container
COPY . /app/

# Train the ML model inside the container
RUN python ml_model.py  # This ensures model.pkl is created

# Expose the application port
EXPOSE 5000

# Run the Flask application
CMD ["python", "app.py"]
