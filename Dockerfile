# 1. Base image
FROM python:3.11-slim

# 2. Set working directory inside container
WORKDIR /app

# 3. Copy application code into container
COPY . /app

# 4. Install dependencies
RUN pip install --no-cache-dir flask

# 5. Expose application port
EXPOSE 8080

# 6. Set environment variable
ENV PORT=8080

# 7. Command to run the app
CMD ["python", "main.py"]
