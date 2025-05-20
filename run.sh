#!/bin/bash

# 使用指南 - Grassroots Analysis 會議分析系統
# 此腳本用於在本地環境中啟動應用程式進行測試

# 顯示執行步驟
set -x

# 確保目錄存在
mkdir -p src/uploads/transcripts src/uploads/rosters src/static/temp

# 安裝Python依賴
echo "正在安裝Python依賴..."
pip install -r requirements.txt

# 啟動應用
echo "正在啟動應用程式..."
python -m src.main

echo "應用程式已啟動！"
echo "您可以通過 http://localhost:5000 訪問應用程式"
