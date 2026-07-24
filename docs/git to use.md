# Git 学习踩坑总结（2026.07）

## 1. Git 与 GitHub 不是一回事（最大的收获）

**踩坑：**

最开始以为：

```
git push
```

会自动在 GitHub 创建仓库。

后来发现：

```
ERROR: Repository not found.
```

**原因：**

Git 只负责版本控制。

GitHub 是远程仓库托管平台。

普通 Git **不能创建 GitHub 仓库**（需要网页或 GitHub CLI `gh`）。

**经验：**

以后牢记：

```
Git
    ↓
本地仓库

GitHub
    ↓
远程仓库
```

Git 只能 push 到已经存在的远程仓库。

------

# 2. git config user.name ≠ GitHub 用户名

**踩坑：**

配置远程仓库时写成：

```
git remote add origin git@github.com:asikana/linux-ops-portfolio.git
```

实际上：

```
asikana
```

只是自己设置的：

```
git config --global user.name
```

GitHub 用户名却是另外一个。

导致：

```
Repository not found.
```

**经验：**

以后区分三个名字：

```
git config user.name
        ↓
Commit 作者

GitHub Username
        ↓
仓库地址

GitHub Name
        ↓
主页显示昵称
```

三者互不影响。

------

# 3. SSH Key 决定身份，不是 user.name

**踩坑：**

一直以为：

```
git config --global user.name
```

决定 push 到哪个账号。

后来验证：

```
ssh -T git@github.com
```

输出：

```
Hi ****!
```

才知道：

GitHub 登录身份由 SSH Key 决定。

**经验：**

排查账号问题：

第一步：

```
ssh -T git@github.com
```

不要先改 Git 配置。

------

# 4. Repository not found 的真正原因

以前看到：

```
Repository not found.
```

第一反应：

> Git 坏了。

后来知道应该依次检查：

```
SSH 是否成功
↓

remote 是否正确

↓

GitHub 是否真的有这个仓库

↓

自己是否有权限
```

而不是重新安装 Git。

------

# 5. git remote 是可以修改的

以前以为：

```
git remote add origin ...
```

写错了只能删仓库。

后来学会：

查看：

```
git remote -v
```

修改：

```
git remote set-url origin <url>
```

删除：

```
git remote remove origin
```

重新添加：

```
git remote add origin <url>
```

以后不用重新 git init。

------

# 6. push rejected (fetch first)

**踩坑：**

出现：

```
! [rejected]
(fetch first)
```

以为权限有问题。

后来知道：

原因是：

GitHub 已经有 commit。

本地也有 commit。

历史不同。

**经验：**

看到：

```
fetch first
```

第一时间想到：

> 远程历史比本地多。

而不是 SSH。

------

# 7. README 初始化导致冲突

GitHub 创建仓库时：

勾选：

```
Initialize this repository with README
```

GitHub 自动产生：

```
README commit
```

本地又：

```
git init

git commit
```

于是：

```
两条历史没有共同祖先
```

导致 push 被拒绝。

**经验：**

以后：

创建空仓库。

不要自动 README。

第一次提交全部由本地完成。

------

# 8. Git 仓库不能嵌套

今天看到：

```
adding embedded git repository
```

才知道：

仓库里面又：

```
git init
```

会产生：

```
.git

↓

linux-ops-portfolio

↓

.git
```

Git 会认为：

这是 Submodule。

以后：

不要在仓库里面再次初始化 Git。

------

# 9. 学会读 Git 报错

以前：

看到报错：

```
fatal
error
rejected
```

今天最大的收获：

开始读 Hint。

例如：

```
Repository not found
```

说明：

仓库不存在。

```
fetch first
```

说明：

远程更新。

```
embedded git repository
```

说明：

仓库套娃。

Git 的 Hint 往往已经告诉了解决方向。

------

# 10. Git 工作流程终于建立

以前只是记命令。

今天真正理解：

```
工作目录

↓

git add

↓

暂存区

↓

git commit

↓

本地仓库

↓

git push

↓

GitHub
```

以后不会把：

```
commit

push

clone

remote
```

混为一谈。

------

# 今日最大的收获（★★★★★）

> **遇到 Git 问题，不再想着重装、重建仓库，而是按照流程排查。**

排查顺序：

```
① git status

↓

② git branch

↓

③ git remote -v

↓

④ ssh -T git@github.com

↓

⑤ git log --oneline --graph --all

↓

⑥ 阅读 Git Hint
```