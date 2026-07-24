# Linux 系统日志读取速查

> 2026-07-24 整理：调试 `tail -f /var/log/syslog` 时整理

---

## 一、syslog 日志格式（所有 Linux 系统日志都长这样）

```
时间戳                     主机名          进程[PID]:   消息内容
Jul 24 10:48:28          DESKTOP-UITNFCS  systemd-resolved[109]:   Clock change detected...
```

| 字段 | 含义 | 示例 |
|------|------|------|
| 时间戳 | 月 日 时:分:秒 | `Jul 24 10:48:28` |
| 主机名 | 哪台机器 | `DESKTOP-UITNFCS` |
| 进程[PID] | 哪个程序 + 进程号 | `systemd-resolved[109]` |
| 消息 | 事件描述 | `Clock change detected...` |

---

## 二、实时跟日志的 3 个最常用组合

### 1. tail -f + grep（过滤关键字）

```bash
tail -f /var/log/syslog | grep -i "error\|fail\|warn"
```

> 只跟 error / fail / warn 这些可疑行，屏蔽噪音。

### 2. 只看最后 N 行（不滚屏）

```bash
tail -n 50 /var/log/syslog
```

### 3. 看某个服务的日志

```bash
journalctl -u systemd-resolved --since "today"
```

---

## 三、典型日志条目解读

### 例 1：时间不同步告警（WSL 常见）

```
systemd-resolved[109]: Clock change detected. Flushing caches.
```

- **意思**：DNS 缓存服务（systemd-resolved）发现系统时间变了
- **为什么会"老是出现"**：WSL 时间经常和 Windows 主机不同步，每次同步都会刷一次
- **影响**：无，缓存重建一次而已
- **解法**：

```bash
# WSL 里手动同步
sudo hwclock -s

# 或者 Windows PowerShell（管理员）里重启 WSL
wsl --shutdown
wsl
```

### 例 2：Ubuntu Pro 服务告警（可忽略）

```
wsl-pro-service[9241]: WARNING Daemon: could not connect to Windows Agent:
could not read agent port file "/mnt/c/Users/1/.ubuntupro/.address"
```

- **意思**：Ubuntu Pro 服务找不到 Windows 端的 agent socket
- **为什么会"老是出现"**：没装 Pro 也没建那个目录
- **影响**：无，纯粹无害噪音
- **解法**：忽略，或彻底卸载：`sudo apt remove ubuntu-pro-client`

---

## 四、读日志的实战流程

```
1. tail -f /var/log/syslog                         # 先跟大杂烩
2. tail -f /var/log/syslog | grep -i "xxx"        # 跟关键字
3. 找到关键行后 Ctrl+C                            # 退出滚动
4. tail -n 100 /var/log/syslog                    # 回看上下文
5. journalctl -u <服务名> --since "1 hour ago"    # 用 journalctl 精确定位
```

---

## 五、按关键字过滤的常用 Pattern

```bash
# 只看错误
tail -f /var/log/syslog | grep -i "error\|fail"

# 排除某些噪音
tail -f /var/log/syslog | grep -v "wsl-pro-service"

# 高亮匹配项
tail -f /var/log/syslog | grep --color=auto "error"

# 同时跟多个文件
tail -F /var/log/syslog /var/log/auth.log
```

> `-F` 比 `-f` 更稳，文件被轮转（rotated）后也能继续跟。

---

## 六、其他日志常用文件位置

| 日志 | 内容 |
|------|------|
| `/var/log/syslog` | 系统综合日志（Ubuntu/Debian） |
| `/var/log/auth.log` | 登录、sudo、SSH 等鉴权日志 |
| `/var/log/kern.log` | 内核日志 |
| `/var/log/dpkg.log` | apt 安装/卸载记录 |
| `/var/log/nginx/` | Nginx 访问/错误日志 |
| `journalctl` | systemd 统一日志（推荐先用这个） |
