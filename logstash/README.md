#  使用方式

#  使用前可以定制修改 logstash-playbook.yaml

## 初始化机器filebeat环境：
```
ansible-playbook -i init_hosts logstash-playbook.yaml --tags init-logstash
```

## 同步配置
```
ansible-playbook -i sync_hosts logstash-playbook.yaml --tags sync-logstash
```
