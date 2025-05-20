from flask import Flask, send_from_directory
import os
import sys
# DON'T CHANGE THIS !!!
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from flask import Flask, send_from_directory
from src.models.analysis import db
from src.routes.upload import upload_bp
from src.routes.analysis import analysis_bp
from src.routes.visualization import visualization_bp

app = Flask(__name__, static_folder=os.path.join(os.path.dirname(__file__), 'static'))
app.config['SECRET_KEY'] = 'asdf#FGSgvasgf$5$WGT'

# 註冊藍圖
app.register_blueprint(upload_bp, url_prefix='/api')
app.register_blueprint(analysis_bp, url_prefix='/api')
app.register_blueprint(visualization_bp, url_prefix='/api')

# 確保上傳目錄存在
def create_upload_folders():
    upload_folders = [
        os.path.join(app.root_path, 'uploads'),
        os.path.join(app.root_path, 'uploads', 'transcripts'),
        os.path.join(app.root_path, 'uploads', 'rosters'),
        os.path.join(app.root_path, 'static', 'temp')
    ]
    for folder in upload_folders:
        os.makedirs(folder, exist_ok=True)

# 在應用啟動時創建目錄
create_upload_folders()

# 啟用資料庫
app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{os.getenv('DB_USERNAME', 'root')}:{os.getenv('DB_PASSWORD', 'password')}@{os.getenv('DB_HOST', 'localhost')}:{os.getenv('DB_PORT', '3306')}/{os.getenv('DB_NAME', 'mydb')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
with app.app_context():
    db.create_all()

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    static_folder_path = app.static_folder
    if static_folder_path is None:
            return "Static folder not configured", 404

    if path != "" and os.path.exists(os.path.join(static_folder_path, path)):
        return send_from_directory(static_folder_path, path)
    else:
        index_path = os.path.join(static_folder_path, 'index.html')
        if os.path.exists(index_path):
            return send_from_directory(static_folder_path, 'index.html')
        else:
            return "index.html not found", 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
