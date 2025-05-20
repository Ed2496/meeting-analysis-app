# Grassroots Analysis 會議分析系統

這是一個專為分析會議字幕與人員工作職稱而設計的網站應用程式，能夠自動解析會議內容，進行Grassroots Tragedy模型分析，並生成視覺化報告。

## 系統主要功能

### 上傳與分析
- 支援純文字格式的會議字幕上傳
- 支援Excel格式的人員職稱資料上傳
- 自動解析會議字幕，提取發言與工作事項

### Grassroots Tragedy模型分析
- 自動比對「會議是表演，流程是擋箭牌，檢討是洗牌，改進是推拖」四大特徵
- 評估各主管的工作職責完成度
- 生成改進建議與分析報告

### 視覺化與報告
- 提供雷達圖與趨勢圖等多種視覺化展示
- 支援郵件格式匯出功能
- 提供歷史追蹤，分析主管表現變化

## 技術架構

- 後端：Flask (Python)
- 資料庫：MySQL
- 前端：HTML, CSS (Tailwind), JavaScript
- 視覺化：Plotly.js
- 資料處理：Pandas, NumPy

## 安裝與部署

### 系統需求
- Python 3.8+
- MySQL 5.7+
- 網頁瀏覽器 (Chrome, Firefox, Safari, Edge)

### 本地安裝

1. 克隆專案
```bash
git clone https://github.com/your-username/grassroots-analysis-app.git
cd grassroots-analysis-app
```

2. 安裝依賴
```bash
pip install -r requirements.txt
```

3. 設置資料庫
```bash
# 在MySQL中創建資料庫
mysql -u root -p
CREATE DATABASE mydb;
```

4. 啟動應用
```bash
python -m src.main
```

5. 訪問網站
在瀏覽器中打開 http://localhost:5000

### GCP部署指南

1. 在GCP上創建VM實例
   - 建議使用 Ubuntu 20.04 LTS
   - 至少 2GB RAM, 1 vCPU

2. 安裝必要軟體
```bash
sudo apt update
sudo apt install -y python3-pip python3-dev mysql-server
```

3. 設置MySQL
```bash
sudo mysql_secure_installation
sudo mysql
CREATE DATABASE mydb;
CREATE USER 'grassroots'@'localhost' IDENTIFIED BY 'your-password';
GRANT ALL PRIVILEGES ON mydb.* TO 'grassroots'@'localhost';
FLUSH PRIVILEGES;
```

4. 克隆與設置專案
```bash
git clone https://github.com/your-username/grassroots-analysis-app.git
cd grassroots-analysis-app
pip3 install -r requirements.txt
```

5. 設置環境變數
```bash
export DB_USERNAME=grassroots
export DB_PASSWORD=your-password
export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=mydb
```

6. 啟動應用
```bash
python3 -m src.main
```

7. 設置防火牆規則
   - 在GCP控制台中，為VM實例添加防火牆規則，允許TCP 5000端口的入站流量

8. 訪問應用
   - 使用VM的外部IP地址訪問：http://[YOUR-VM-IP]:5000

## 使用指南

### 上傳檔案

1. 會議字幕上傳
   - 支援純文字(.txt)格式
   - 格式要求：每行以發言人名稱開頭，後跟發言內容

2. 人員職稱上傳
   - 支援Excel(.xlsx, .xls)格式
   - 需包含姓名、職稱、部門等欄位

### 分析會議

1. 從下拉選單中選擇已上傳的會議
2. 點擊「分析會議」按鈕
3. 系統將自動進行分析並顯示結果

### 查看分析結果

1. 總覽標籤：顯示會議整體分析與所有發言人的Grassroots Tragedy指數
2. 個別分析標籤：選擇特定員工查看詳細分析報告與雷達圖
3. 比較分析標籤：比較不同員工的Grassroots Tragedy特徵
4. 匯出報告標籤：生成郵件格式或Excel報告

## 維護與更新

### 資料備份
建議定期備份MySQL資料庫：
```bash
mysqldump -u root -p mydb > mydb_backup.sql
```

### 系統更新
```bash
cd grassroots-analysis-app
git pull
pip install -r requirements.txt
```

## 故障排除

1. 資料庫連接問題
   - 檢查環境變數設置
   - 確認MySQL服務正在運行

2. 檔案上傳失敗
   - 檢查檔案格式是否正確
   - 確認上傳目錄權限

3. 分析結果不準確
   - 檢查人員職稱資料是否完整
   - 確認會議字幕格式是否符合要求

## 聯絡支援

如有任何問題或需要技術支援，請聯絡：
- 電子郵件：support@grassroots-analysis.com
- 技術支援熱線：+886-2-12345678
