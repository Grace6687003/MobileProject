from flask import Flask, request, jsonify
from flask_cors import CORS
import socket

app = Flask(__name__)
CORS(app) 

@app.route('/api/nearby-stores', methods=['GET'])

def get_nearby_stores():
    # จำลอง location-based ใส่ได้จาก google map เลย
    return jsonify({
        "stores": [
            {
                "name": "ตลาดศาลายา",
                "lat": 13.8017772,
                "lng": 100.3235705,
                "open": "05:00",
                "close": "20:00"
            },
            {
                "name": "ตลาดเล็ก",
                "lat": 13.801740297028683,
                "lng": 100.31562718309763,
                "open": "05:00",
                "close": "20:00"
            },
            {
                "name": "ตลาดใหม่ศาลายา",
                "lat": 13.803106989970475,
                "lng": 100.31283671460297,
                "open": "02:00",
                "close": "13:00"
            }
        ]
    })

if __name__ == '__main__':
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)
    
    print(f"\n Flask is running! Open in browser:")
    print(f"    http://{local_ip}:5000/\n")
    
    app.run(debug=True, host='0.0.0.0', port=5000)
