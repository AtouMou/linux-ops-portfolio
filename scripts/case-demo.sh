#!/bin/bash
# case 语句演示

echo "=== 简单菜单 ==="
echo "1. 查看系统信息"
echo "2. 查看磁盘使用"
echo "3. 查看内存使用"
echo "q. 退出"

read -p "请选择: " choice

case $choice in
    1)
        echo "=== 系统信息 ==="
        uname -a
        ;;
    2)
        echo "=== 磁盘使用 ==="
        df -h
        ;;
    3)
        echo "=== 内存使用 ==="
        free -h
        ;;
    q|Q)
        echo "退出"
        exit 0
        ;;
    *)
        echo "无效选择"
        exit 1
        ;;
esac
