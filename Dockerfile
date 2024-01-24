# Use an official Python runtime as a parent image
FROM alpine:latest

# Disable python stdout/stderr buffering
ENV PYTHONUNBUFFERED=1

# Add testing repository to install Python 3.10
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.14/testing/" >> /etc/apk/repositories

# Set the working directory to /app
WORKDIR /crm

# Copy the current directory contents into the container at /app
COPY . /crm

# Install Python 3.10, pip, and setuptools
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/v3.14/testing/ py3-pip

# Install any needed packages specified in requirements.txt and create django db
RUN pip install --trusted-host pypi.python.org -r requirements.txt --break-system-packages; \
    python3 manage.py makemigrations; \
    python3 manage.py migrate

# Make port 8000 available to the world outside this container
# EXPOSE 8000/tcp

# Run manage.py when the container launches
# CMD ["sh", "-c", "python3 manage.py runserver 0.0.0.0:8000"]
