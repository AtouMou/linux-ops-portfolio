#!/bin/bash
# 批量 SCP 推送脚本

# 服务器列表
SERVERS=(
    "user1@server1"
    "user2@server2"
    "user3@server3"
)

# 本地文件
LOCAL_FILE="/path/to/file"
REMOTE_PATH="/path/on/server"

for server in "${SERVERS[@]}"; do
    echo "=== 推送: $server ==="
    scp "$LOCAL_FILE" "$server:$REMOTE_PATH"
done
