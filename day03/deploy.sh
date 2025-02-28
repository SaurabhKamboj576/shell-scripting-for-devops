#!/bin/bash

# Deployment of Django app with error handling

code_clone() {
    echo "Cloning the Django app..."
    if [ -d "django-notes-app" ]; then
        echo "The code directory already exists. Skipping clone..."
        cd django-notes-app || exit 1
    else
        git clone https://github.com/LondheShubham153/django-notes-app.git || {
            echo "Failed to clone repository!"
            exit 1
        }
        cd django-notes-app || exit 1
    fi
}

install_requirements() {
    echo "Installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y docker.io nginx docker-compose || {
        echo "Installation failed!"
        exit 1
    }
}

required_restarts() {
    echo "Configuring services..."
    sudo chown $USER /var/run/docker.sock
    sudo chown -R $USER:$USER data/mysql/db/
    sudo systemctl enable --now docker
    sudo systemctl enable --now nginx
    sudo systemctl restart docker

}

deploy() {
    echo "Deploying the application..."
    
    # Stop and remove any existing container
    existing_container=$(docker ps -aq --filter "name=notes-app")
    if [ -n "$existing_container" ]; then
        echo "Stopping existing container..."
        docker stop "$existing_container"
        docker rm "$existing_container"
    fi
    
    # Build and run the container
    docker build -t notes-app . || {
        echo "Docker build failed!"
        exit 1
    }
    docker-compose run -d -p 8080:80 nginx || {
        echo "Docker run failed!"
        exit 1
    }
}

echo "****************************** Deployment Started ***************************"

code_clone
install_requirements
required_restarts
deploy

echo "***************************** Deployment Done ********************************"
