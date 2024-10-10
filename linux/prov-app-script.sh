#!/bin/bash

# Check for updates
echo "update sources list..."
sudo apt update -y
echo "update complete"

# Upgrades those checks
echo "upgrade any packages available..."
sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
echo "upgrade complete"

# Install nginx
sudo apt install -y nginx
echo "nginx installed"


# Modify Nginx configuration to set up reverse proxy
sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
echo "Nginx reverse proxy configuration updated"

# Test the Nginx configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
echo "Nginx restarted with reverse proxy"

echo "install nodejs v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

echo "check nodejs version..."
node -v
echo "nodejs v20 installed"

# Install pm2 globally
sudo npm install -g pm2


# Cloning Git repo
echo "Clone Git folder"
git clone https://github.com/corinnai/tech264-sparta-app.git repo
echo "Cloned tech264-sparta-app"


echo "Change directory to app"
cd repo/app
echo "In app directory"

#Set MongoDB connecting string
export DB_HOST="mongodb://10.0.3.5:27017/posts"


# Stop all existing pm2 processes
pm2 stop all

echo "install and run"
npm install
echo npm "install done"


echo "start"
pm2 start app.js
echo "App started with pm2"