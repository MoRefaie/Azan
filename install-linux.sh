#!/bin/bash
set -e

# -----------------------------
# Color definitions
# -----------------------------
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${BLUE}${BOLD}Installing Azan...${RESET}"

INSTALL_DIR="/opt/azan"
RELEASE_URL="https://github.com/MoRefaie/Azan/releases/latest/download/Azan-linux-installer.tar.gz"
TMP_DIR="/tmp/azan-install"

echo -e "${YELLOW}Preparing temporary directory...${RESET}"
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"
cd "$TMP_DIR"

echo -e "${YELLOW}Downloading Azan installer package...${RESET}"
wget --progress=bar:force -O Azan-linux-installer.tar.gz "$RELEASE_URL"

echo -e "${YELLOW}Extracting package...${RESET}"
tar -xzf Azan-linux-installer.tar.gz

echo -e "${YELLOW}Stopping Azan service if running...${RESET}"
systemctl stop azan 2>/dev/null || true

echo -e "${YELLOW}Creating install directory...${RESET}"
mkdir -p "$INSTALL_DIR"

echo -e "${YELLOW}Copying binaries...${RESET}"
cp AzanUI "$INSTALL_DIR/AzanUI"
cp AzanScheduler "$INSTALL_DIR/AzanScheduler"
chmod +x "$INSTALL_DIR/AzanUI" "$INSTALL_DIR/AzanScheduler"

echo -e "${YELLOW}Setting ownership...${RESET}"
chown -R root:root "$INSTALL_DIR"

echo -e "${YELLOW}Creating symlink...${RESET}"
ln -sf "$INSTALL_DIR/AzanScheduler" /usr/local/bin/azan

echo -e "${YELLOW}Creating systemd service...${RESET}"
cat << SERVICE > /etc/systemd/system/azan.service
[Unit]
Description=Azan Service
After=network.target

[Service]
ExecStartPre=/usr/bin/test -x /opt/azan/AzanScheduler
ExecStart=/opt/azan/AzanScheduler
WorkingDirectory=/opt/azan
Restart=always
User=root

[Install]
WantedBy=multi-user.target
SERVICE

echo -e "${YELLOW}Enabling and restarting service...${RESET}"
systemctl daemon-reload
systemctl enable azan
systemctl restart azan || systemctl start azan

echo -e "${YELLOW}Cleaning up...${RESET}"
rm -rf "$TMP_DIR"

# -----------------------------
# Detect server IP for access URL
# -----------------------------
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo -e "${GREEN}${BOLD}Installation complete!${RESET}"
echo ""
echo -e "${BLUE}Azan is now running as a systemd service.${RESET}"
echo ""
echo -e "${YELLOW}Service commands:${RESET}"
echo "  sudo systemctl start azan"
echo "  sudo systemctl stop azan"
echo "  sudo systemctl restart azan"
echo "  sudo systemctl status azan"
echo ""
echo -e "${GREEN}You can now access Azan at:${RESET}"
echo -e "  ${BOLD}http://azan.local${RESET}"
echo -e "  ${BOLD}http://$SERVER_IP${RESET}"
echo ""
echo -e "${BLUE}If you want to run Azan manually (not recommended), use:${RESET}"
echo "  azan"
echo ""
echo -e "${GREEN}Thank you for installing Azan!${RESET}"
echo ""