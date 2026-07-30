# Sử dụng base image Python 3.12 trên nền Debian để ổn định
FROM python:3.12-slim

# Cài đặt FFmpeg và các dependency cần thiết
RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt WhisperX từ GitHub
RUN pip install git+https://github.com/m-bain/whisperx.git

# Tạo thư mục làm việc
WORKDIR /data

# Thiết lập entrypoint để chạy lệnh
ENTRYPOINT ["whisperx"]
