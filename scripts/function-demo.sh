#!/bin/bash
# 函数演示

# 打印分隔线
print_line() {
    echo "=================================="
}

# 获取系统信息
get_system_info() {
    echo "主机名: $(hostname)"
    echo "系统: $(uname -s)"
    echo "内核: $(uname -r)"
}

# 检查服务状态
check_service() {
    if systemctl is-active --quiet "$1"; then
        echo "$1: 运行中"
    else
        echo "$1: 未运行"
    fi
}

# 主程序
print_line
echo "系统信息"
print_line
get_system_info

echo ""
print_line
echo "服务状态"
print_line
check_service nginx
check_service mysql
check_service redis
check_service docker
print_line
