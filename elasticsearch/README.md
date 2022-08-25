# master节点配置：
    4c8g 40GB系统盘 40G的数据盘
# coordinate节点配置：
    4c8g 40GB系统盘 40G的数据盘
# ingest节点配置
    4c8g 40GB系统盘 40G的数据盘
# hot node节点配置：
    8c32g 40GB系统盘 40GB HDD + N * 2T SSD
# warm node节点配置：
    8c32g 40GB系统盘 40GB HDD + N * 2T HDD
# cold node节点配置：
	4c16g 40GB系统盘 40GB HDD + 4 * 2T HDD

    N = 50(用于日志系统的内存磁盘比例) * 16GB (mem for jvm heap)  / 2048GB ~= 1


# 命令备注
# 初始化安装
ansible-playbook -i ./cluster/sre-elasticsearch/hosts -e @./cluster/sre-elasticsearch/vars.yaml init.yaml

