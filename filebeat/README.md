#  使用方式

## 初始化机器filebeat环境：
```
ansible-playbook -i init_hosts filebeat.yaml --tags init-filebeat
```

## 同步 filebeat 自身配置
```
ansible-playbook -i sync_hosts filebeat.yaml --tags sync-filebeat
```

## 清理filbeat环境
```
ansible-playbook -i init_hosts filebeat.yaml --tags del-filebeat
```
# 下发配置
## 1. 普通虚拟机 非container 独立部署服务/混布服务

## 2. 普通虚拟机 container 独立部署服务

## 3. 普通虚拟机 container 混布服务

## 4. kubernetes container 日志走独立走 daemonset 和 sidecar 模式,在此项目不做处理
