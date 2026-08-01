#!/bin/bash
# 条件判断演示

echo "=== 数值比较 ==="
num1=10
num2=20
if [ $num1 -lt $num2 ]; then
    echo "$num1 < $num2"
fi

echo ""
echo "=== 文件检查 ==="
if [ -f "/etc/hosts" ]; then
    echo "/etc/hosts 存在且是普通文件"
fi

if [ -d "/tmp" ]; then
    echo "/tmp 是目录"
fi

echo ""
echo "=== 字符串比较 ==="
name="admin"
if [ "$name" = "admin" ]; then
    echo "欢迎，管理员！"
elif [ "$name" = "user" ]; then
    echo "欢迎，用户！"
else
    echo "欢迎，访客！"
fi

echo ""
echo "=== 复合条件 ==="
file="/etc/passwd"
if [ -r "$file" ] && [ -s "$file" ]; then
    echo "$file 可读且非空"
fi
