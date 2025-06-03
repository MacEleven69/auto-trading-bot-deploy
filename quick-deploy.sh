#!/bin/bash
# VIX Auto Trading Bot - One-Liner Installer
# Usage: curl -sSL https://raw.githubusercontent.com/MacEleven69/auto-trading-bot-deploy/main/quick-deploy.sh | bash

echo "🚀 VIX Auto Trading Bot - Quick Deploy"
echo "======================================"

# Update system
echo "📦 Updating system..."
apt update && apt upgrade -y

# Install Docker
echo "🐳 Installing Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    systemctl enable docker
    systemctl start docker
fi

# Install Docker Compose
echo "🔧 Installing Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Create app directory
echo "📁 Setting up application..."
mkdir -p /root/auto_trading_bot
cd /root/auto_trading_bot

# Download deployment package
echo "⬇️  Downloading trading bot files..."
wget -q https://github.com/MacEleven69/auto-trading-bot-deploy/raw/main/auto_trading_bot_docker_20250603_002556.zip
unzip -q auto_trading_bot_docker_20250603_002556.zip
cp -r vultr_docker_deployment/* .

# Create environment file template
echo "🔑 Creating environment template..."
cat > .env << 'EOF'
ALPACA_API_KEY=your_alpaca_api_key_here
ALPACA_SECRET_KEY=your_alpaca_secret_key_here
POLYGON_API_KEY=your_polygon_api_key_here
ALPACA_BASE_URL=https://paper-api.alpaca.markets
EOF

echo ""
echo "✅ Installation Complete!"
echo ""
echo "🔑 NEXT STEPS:"
echo "1. Edit your API keys: nano .env"
echo "2. Start the bot: docker-compose up -d"
echo "3. Check status: docker-compose ps"
echo "4. View logs: docker-compose logs -f"
echo "5. Access dashboard: http://$(curl -s ifconfig.me):8893"
echo ""
echo "🚀 Your VIX Auto Trading Bot is ready!"
