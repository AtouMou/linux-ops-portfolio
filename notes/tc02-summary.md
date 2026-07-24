# TC-02 Linux 基础命令 - 学习总结

> 完成日期：2026-07-24
> 学习时长：约 3 小时
> 总体评价：知识巩固型，查漏补缺效果良好

---

## 一、本次学习的知识体系

```
TC-02 Linux 基础命令
├── TC02-01 文件操作命令（ls/cd/mkdir/touch/cp/mv/rm）
├── TC02-02 文本处理命令（echo/wc/grep/管道/重定向/cut/sort）
├── TC02-03 查找命令（find/which/whereis/locate）
├── TC02-04 压缩解压（tar/gzip/zip）
├── TC02-05 系统监控（top/ps/free/df/du/uptime）
├── TC02-06 网络命令（ping/curl/wget/ss/ip）
├── TC02-07 Cheatsheet 整理
└── TC02-08 综合实验
```

---

## 二、本次重点巩固的薄弱环节

### 1. 管道与重定向（TC02-02）

之前模糊，现在清晰了：

```bash
cmd1 | cmd2          # 管道：前一个的输出给后一个
cmd > file.txt       # 覆盖重定向
cmd >> file.txt      # 追加重定向
cmd 2> err.txt       # 只重定向错误
cmd > all.txt 2>&1  # 错误和标准输出都重定向到同一文件
```

**核心理解**：
- `>` 覆盖，`>>` 追加
- `1` 是标准输出（stdout），`2` 是错误输出（stderr）
- `2>&1` 的顺序很重要，`>file 2>&1` 对，但 `2>&1 >file` 错

### 2. tail -f 实时日志分析（TC02-01 / TC02-02）

```bash
tail -f /var/log/syslog                          # 实时跟日志
tail -f /var/log/syslog | grep -i "error"      # 只跟错误
tail -f /var/log/syslog | grep -v "噪音服务"    # 排除某些噪音
```

**syslog 日志格式**：
```
时间戳    主机名    进程[PID]:    消息
```

### 3. 压缩命令优先级（TC02-04）

- `tar -czvf` / `tar -xzvf`：最最最常用，记这两个就够了
- `gzip` / `gunzip`：单文件压缩
- `zip` / `unzip`：跨平台时用
- `bz2` 格式可以跳过

### 4. 进程与内存监控（TC02-05）

```bash
top                    # 实时进程，q 退出，P/M/N/T 排序
ps aux | grep nginx   # 查找特定进程
free -h               # 内存使用
df -h                 # 磁盘使用
du -sh * | sort -rh  # 各目录大小，按大到小排
uptime                # 负载：1分钟/5分钟/15分钟平均值
```

**Load Average 理解**：
- 负载数 4 + 4 核 CPU = 满载
- 负载数 4 + 8 核 CPU = 还有余量

### 5. 网络命令（TC02-06）

```bash
ping -c 4 8.8.8.8             # 连通性测试
curl -I https://example.com   # HTTP 头
ss -tlnp | grep :80          # 查端口占用（推荐用 ss 而非 netstat）
ip addr                       # IP 配置
```

---

## 三、本次新增的实战技巧

### 1. 日志分析管道组合

```bash
# 统计某类错误出现次数
grep -c "error" /var/log/syslog

# 分析 nginx 访问日志 Top IP
tail -100 /var/log/nginx/access.log | cut -d' ' -f1 | sort | uniq -c | sort -rn | head -10

# 找最大的目录
du -sh /* 2>/dev/null | sort -rh | head -10
```

### 2. find 的实用组合

```bash
find / -type f -size +100M 2>/dev/null    # 找大文件
find . -mtime -7                          # 7天内修改的文件
find . -name "*.tmp" -delete             # 找到并删除
```

### 3. 管道链的思维

```
ps aux --sort=-%mem | head -10           # 内存最高的进程
ls -lh | sort -k5 -h                     # 按文件大小排序
```

---

## 四、容易踩的坑

| 坑 | 说明 |
|----|------|
| `rm -rf /` | 永远不要在根目录跑 rf |
| `2>&1` 顺序 | 必须是 `>file 2>&1`，不是反过来 |
| `cp -r` 目录 | 复制目录必须加 -r |
| `tail -f` 没反应 | 可能文件不存在或没有写权限 |
| tar 不带 -z | `tar -xvf` 解压 .tar.gz 会报错 |

---

## 五、下一步方向

- **TC02-06 网络命令**：还没跑过，实用性强，建议优先补
- **TC02-08 综合实验**：真实场景模拟，检验整体掌握程度
- **TC-02A Shell 脚本基础**：自然延伸
