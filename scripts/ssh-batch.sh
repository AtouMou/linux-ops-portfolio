#!/bin/bash
# 批量 SSH 执行脚本

# 服务器列表
SERVERS=(
    "user1@server1:2222"
    "user2@server2:2222"
    "user3@server3:2222"
)

# 要执行的命令
COMMAND="uptime"

# 遍历执行
for server in "${SERVERS[@]}"; do
    echo "=== 执行: $server ==="
    ssh -p ${server#*:} ${server%:*} "$COMMAND"
    echo ""
done
