#!/bin/bash

# 部署腳本 - Grassroots Analysis 會議分析系統
# 此腳本用於在GCP環境中部署應用程式

# 顯示執行步驟
set -x

# 安裝必要套件
sudo apt update
sudo apt install -y python3-pip python3-dev mysql-server

# 設置MySQL (需要手動輸入密碼)
echo "正在設置MySQL..."
echo "請在接下來的步驟中設置MySQL root密碼"
sudo mysql_secure_installation

# 創建資料庫和用戶
echo "正在創建資料庫和用戶..."
sudo mysql -e "CREATE DATABASE IF NOT EXISTS mydb;"
sudo mysql -e "CREATE USER IF NOT EXISTS 'grassroots'@'localhost' IDENTIFIED BY 'grassroots-password';"
sudo mysql -e "GRANT ALL PRIVILEGES ON mydb.* TO 'grassroots'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# 安裝Python依賴
echo "正在安裝Python依賴..."
pip3 install -r requirements.txt

# 設置環境變數
export DB_USERNAME=grassroots
export DB_PASSWORD=grassroots-password
export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=mydb

# 將環境變數添加到.bashrc以便持久化
echo "export DB_USERNAME=grassroots" >> ~/.bashrc
echo "export DB_PASSWORD=grassroots-password" >> ~/.bashrc
echo "export DB_HOST=localhost" >> ~/.bashrc
echo "export DB_PORT=3306" >> ~/.bashrc
echo "export DB_NAME=mydb" >> ~/.bashrc

# 創建systemd服務檔案以便自動啟動
echo "正在創建systemd服務..."
sudo tee /etc/systemd/system/grassroots-analysis.service > /dev/null << EOL
[Unit]
Description=Grassroots Analysis Web Application
After=network.target mysql.service

[Service]
User=$(whoami)
WorkingDirectory=$(pwd)
Environment="DB_USERNAME=grassroots"
Environment="DB_PASSWORD=grassroots-password"
Environment="DB_HOST=localhost"
Environment="DB_PORT=3306"
Environment="DB_NAME=mydb"
ExecStart=/usr/bin/python3 -m src.main
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# 啟用並啟動服務
sudo systemctl daemon-reload
sudo systemctl enable grassroots-analysis.service
sudo systemctl start grassroots-analysis.service

# 檢查服務狀態
sudo systemctl status grassroots-analysis.service

# 設置防火牆規則 (如果使用ufw)
sudo ufw allow 5000/tcp

echo "部署完成！"
echo "您可以通過 http://$(hostname -I | awk '{print $1}'):5000 訪問應用程式"
