# Script for app 

```bash
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

echo "install nodejs v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - &&\
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

echo "check nodejs version..."
node -v
echo "nodejs v20 installed"

# Cloning Git repo
echo "Clone Git folder"
git clone https://github.com/corinnai/tech264-sparta-app.git repo
echo "Cloned tech264-sparta-app"

echo "Change directory to app"
cd repo/app
echo "In app directory"

#Set MongoDB connecting string
export DB_HOST=mongodb://10.0.3.5:27017

echo "install and run"
npm install
echo npm "install done"


echo "start"
node app.js &
```

# ------------- Script for installing DB-----------

```bash
#!/bin/bash
 
# Update the system package list
echo Updating package list...
sudo apt-get update -y
echo Done!
 
# Upgrade all installed packages to their latest versions
echo Upgrading installed packages...
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo Done!
 
echo Installing gnupg and curl...
sudo apt-get install gnupg curl -y
echo Done!
 
# Download and add MongoDB GPG key for package verification
echo Adding MongoDB GPG key...
sudo rm -f /usr/share/keyrings/mongodb-server-7.0.gpg # Remove key if one exists
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg --yes -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo Done!
 
# Add MongoDB repository to the sources list
echo Adding MongoDB repository to sources list...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
echo Done!
 
# Update package list again to include the newly added MongoDB repository
echo Updating package list with MongoDB repository...
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
echo Done!
 
# Install MongoDB version 7.0.6 and specific associated packages non-interactively
echo Installing MongoDB and related packages...
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    mongodb-org=7.0.6 \
    mongodb-org-database=7.0.6 \
    mongodb-org-server=7.0.6 \
    mongodb-org-shell=7.0.6 \
    mongodb-org-mongos=7.0.6
echo Done!
 
# Start MongoDB service immediately
echo Starting MongoDB service...
sudo systemctl start mongod
echo Done!
 
# Enable MongoDB service to start on boot
echo Enabling MongoDB service to start on boot...
sudo systemctl enable mongod
echo Done!
 
# Modify MongoDB configuration to allow remote connections
echo Configuring MongoDB to allow remote connections...
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
echo Done!
 
# Restart MongoDB service to apply configurations
echo Restarting MongoDB service...
sudo systemctl start mongod
echo Done!
```

# Reverse proxy 

```bash
# Backup the Nginx Configuration File:
- sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup

# Open the Nginx Configuration File for Editing:
-sudo nano /etc/nginx/sites-available/default

# Modify the Nginx Configuration:
from 

-location / {
    try_files $uri $uri/ =404;
    }
 to
 
location / {
    proxy_pass http://localhost:3000;
    }

# Save and Exit

# Test the Nginx Configuration:
-sudo nginx -t
- nginx: configuration file /etc/nginx/nginx.conf test is successful


# Restart Nginx:
-sudo systemctl restart nginx
```


# Run Sparta app in the background

```bash
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
 
# Backup the default Nginx configuration
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
echo "Nginx configuration file backed up"
 
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
 
 
# Check if the repo directory exists and remove it if necessary
if [ -d "repo" ]; then
  echo "Removing existing repo directory"
  sudo rm -rf repo
fi
 
# Cloning Git repo
echo "Clone Git folder"
git clone https://github.com/corinnai/tech264-sparta-app.git repo
echo "Cloned tech264-sparta-app"
 
 
echo "Change directory to app"
cd repo/app
echo "In app directory"
 
#Set MongoDB connecting string
export DB_HOST=mongodb://10.0.3.5:27017
 
 
# Install pm2 globally
sudo npm install -g pm2
 
# Stop all existing pm2 processes
pm2 stop all
 
echo "install and run"
npm install
echo npm "install done"
 
 
echo "start"
pm2 start app.js
echo "App started with pm2"
```
# -------------------- App script-----------------
```bash
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
```
 
