
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


