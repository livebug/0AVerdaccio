
## 0. 安装
外网安装执行 `npm install -g verdaccio`

内网安装将外网的node+npm 挪到内网，设置环境变量

## 1. 启动
已经组织了脚本，执行`server.ps1`即可

### 1.1 Q:因为在此系统上禁止运行脚本
执行如下命令设置可用
```powershell
set-executionpolicy remotesigned
```

## 2. 增加用户
```bash
$ npm adduser --registry http://localhost:4873/
npm notice Log in on http://localhost:4873/
Username: admin
Email: (this IS public)
Email: (this IS public) admin@aaa.com
Logged in on http://localhost:4873/.
```

## 3. 调整npm设置，npm设置源地址
```bash
$ npm set registry http://localhost:4873/
```

## 4.使用pm2 来后台启动
### 4.1 基本安装
```bash
# 安装pm2 
npm i -g pm2

pm2 list # 检查状态

# 启动应用
# windows 中使用 json启动
pm2 start ./ecosystem.config.js

# 查看状态
pm2 status 
```
### 4.2 日志管理
安装插件`pm2-logrotate`
```bash
pm2 install pm2-logrotate # 用pm2安装不是npm
# 设置最大大小
pm2 set pm2-logrotate:max_size 1K
pm2 restart all #重启生效
```
### 4.3 开机自启
```bash
# Windows需要安装其他东西
npm install pm2-windows-startup -g
pm2-startup install
pm2 save # 保存当前应用，重启时起作用
```

