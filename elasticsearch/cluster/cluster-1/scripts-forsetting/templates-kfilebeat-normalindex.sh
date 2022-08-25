#!/bin/bash
# 设置template 对 index 优化
# 1、设置副本数目为 0
# 2、设置分片数目，数目根据data节点数量觉得，推荐值为: ( 副本数 + 1 ) * 分片数目 = 机器数目
# 3、translog 设为异步，在提高性能的同时降低了一点数据安全性
# 4、慢查询相关设置

# 永远别使用 template: "*"

# default kfilebeat_*
/usr/bin/curl -H "Content-Type:application/json" --user elastic:elastic -XPUT "http://172.16.0.1:9200/_template/template_default_kfilebeat_*" -d '
{
    "order": 1,
    "template": "kfilebeat_*",
    "settings": {
        "index.routing.allocation.require.box_type": "warm",
        "index.lifecycle.name": "nohotwarm-15days-for-normal-index",
        "number_of_replicas": 0,
        "number_of_shards": 1,
        "index.translog.durability": "async",
        "index.translog.sync_interval": "120s",
        "index.translog.flush_threshold_size": "1024mb",
        "index.refresh_interval" : "10s",
        "index.routing.allocation.total_shards_per_node": 1,
        "index.unassigned.node_left.delayed_timeout": "360m",
        "index.search.slowlog.threshold.query.info": "500ms",
        "index.search.slowlog.threshold.query.debug": "100ms",
        "index.search.slowlog.threshold.fetch.info": "1s",
        "index.search.slowlog.threshold.fetch.debug": "200ms"
    }
}

