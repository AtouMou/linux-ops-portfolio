#!/bin/bash
# 循环语句演示

echo "=== for 循环：1到10 ==="
for i in {1..10}; do
    echo -n "$i "
done
echo ""

echo ""
echo "=== for 循环：遍历数组 ==="
services=("nginx" "mysql" "redis" "docker")
for service in "${services[@]}"; do
    echo "检查服务: $service"
done

echo ""
echo "=== while 循环：倒计时 ==="
count=5
while [ $count -gt 0 ]; do
    echo "倒计时: $count"
    sleep 1
    count=$((count-1))
done
echo "开始！"

echo ""
echo "=== for 循环：文件批量处理 ==="
# 创建测试文件
mkdir -p /tmp/test_files
for i in 1 2 3; do
    echo "Content $i" > /tmp/test_files/file$i.txt
done

# 批量处理
for f in /tmp/test_files/*.txt; do
    echo "处理: $f ($(cat $f))"
done

# 清理
rm -rf /tmp/test_files
