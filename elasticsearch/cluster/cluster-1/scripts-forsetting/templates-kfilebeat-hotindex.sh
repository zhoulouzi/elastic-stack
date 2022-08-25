# index hot node

# number_of_shards 和 index.routing.allocation.total_shards_per_node 必须考虑当前 hotnode节点数目
# 永远别使用 template: "*"\

#
/usr/bin/curl -H "Content-Type:application/json" --user elastic:elastic -XPUT "http://172.16.0.1:9200/_template/template_kfilebeat_*" -d '
{
    "order": 2,
    "template": "kfilebeat_*",
    "settings": {
        "index.routing.allocation.require.box_type": "hot",
        "index.lifecycle.name": "hotwarm-rollover50GB-15days-for-hot-index",
        "number_of_replicas": 0,
        "number_of_shards": 3,
        "index.translog.durability": "async",
        "index.translog.flush_threshold_size": "1024mb",
        "index.translog.sync_interval": "120s",
        "index.refresh_interval" : "10s",
        "index.unassigned.node_left.delayed_timeout": "360m",
        "index.search.slowlog.threshold.query.info": "500ms",
        "index.search.slowlog.threshold.query.debug": "100ms",
        "index.search.slowlog.threshold.fetch.info": "1s",
        "index.search.slowlog.threshold.fetch.debug": "200ms",
        "index.routing.allocation.total_shards_per_node": 1
    }
}
'