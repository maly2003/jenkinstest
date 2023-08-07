#!/bin/bash

#nginx app check
if command -v nginx &>/dev/null; then
  echo "Nginx has already installed"
else
  echo "Installing Nginx..."
  sudo dnf install -y nginx
fi

#nginx service check
if sudo systemctl is-active --quiet nginx; then
  echo "Nginx service is running"
else
  echo "Trying to lounch Nginx service..."
  sudo systemctl enable --now nginx.service
fi

#nginx service status show
sudo systemctl status nginx | grep Active

#firewall rule check
if sudo firewall-cmd --query-service=http &>/dev/null; then
  echo "HTTP rule has already enabled in firewall"
else
  echo "Adding HTTP rule to firewall..."
  sudo firewall-cmd --add-service=http --permanent
  sudo firewall-cmd --reload
fi

exit 0
