#!/bin/bash
# Shell performance

name="engineer"
skills="linux docker shell"

echo “"===================="
echo "name:$name"
echo "skills:$skills"
echo ""

#command replace
current_date=$(date +"%Y-%m-%d")
current_time='date +"%H:%M:%S"'
echo "当前日期: $current_date"
echo "当前时间: $current_time"
echo ""

# 特殊变量演示
echo "=== 特殊变量 ==="
echo "脚本名: $0"
echo "参数1: $1"
echo "参数2: $2"
echo "参数个数: $#"
echo "所有参数: $@"
echo "当前进程ID: $$"
