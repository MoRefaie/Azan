#!/bin/bash
set -e

echo "Installing Azan..."

INSTALL_DIR="/opt/azan"
RELEASE_URL="https://github.com/MoRefaie/Azan/releases/latest/download/Azan-linux-installer.tar.gz"
TMP_DIR="/tmp/azan-install"

echo "Preparing temporary directory..."
rm -rf $TMP_DIR
mkdir -p $TMP_DIR
cd $TMP_DIR

echo "Downloading Azan installer package..."
curl -fsSL -o Azan-linux-installer.tar.gz "$RELEASE_URL"

echo "Extracting package..."
tar -xzf Azan-linux-installer.tar.gz

echo "Creating install directory..."
sudo mkdir -p $INSTALL_DIR

echo "Copying binaries..."
sudo cp AzanUI $INSTALL_DIR/AzanUI
sudo cp AzanSchedular $INSTALL_DIR/AzanSchedular
sudo chmod +x $INSTALL_DIR/AzanUI $INSTALL_DIR/AzanSchedular

echo "Setting ownership..."
sudo chown -R root:root $INSTALL_DIR

echo "Creating symlink..."
sudo ln -sf $INSTALL_DIR/AzanSchedular /usr/local/bin/azan

echo "Creating systemd service..."
sudo bash -c 'cat << SERVICE > /etc/systemd/system/azan.service
[Unit]
Description=Azan Service
After=network.target

[Service]
ExecStartPre=/usr/bin/test -x /opt/azan/AzanSchedular
ExecStart=/opt/azan/AzanSchedular
WorkingDirectory=/opt/azan
Restart=always
User=root

[Install]
WantedBy=multi-user.target
SERVICE'

echo "Enabling service..."
sudo systemctl daemon-reload
sudo systemctl enable azan
sudo systemctl start azan

echo "Cleaning up..."
rm -rf $TMP_DIR

echo "Installation complete!"
echo ""
echo "Azan is now running as a systemd service."
echo "To start the service:     sudo systemctl start azan"
echo "To stop the service:      sudo systemctl stop azan"
echo "To restart the service:   sudo systemctl restart azan"
echo "To check its status:      sudo systemctl status azan"
echo ""
echo "If you want to run Azan manually (not recommended), use:"
echo "    azan"
