#!/bin/bash
# Shell 数组演示

# 定义数组
servers=("web-01" "web-02" "db-01" "cache-01")

echo "=== 服务器列表 ==="
echo "所有服务器: ${servers[@]}"
echo "服务器数量: ${#servers[@]}"
echo ""

echo "=== 遍历服务器 ==="
for server in "${servers[@]}"; do
    echo "  - $server"
done
echo ""

echo "=== 查找服务器 ==="
search="db-01"
for server in "${servers[@]}"; do
    if [ "$server" == "$search" ]; then
        echo "找到: $server"
    fi
done
