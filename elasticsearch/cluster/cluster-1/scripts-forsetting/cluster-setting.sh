# 集群设置
# 1、 所有shard active 才允许rebalance
# 2、 segement merge限速 100mb/s
# 3、 磁盘使用率 80% 停止分配新的shard
#              90% relocate shard
#              1m 检查一次 磁盘使用率
/usr/bin/curl -H "Content-Type:application/json" --user elastic:elastic -XPUT "http://172.16.0.1:9200/_cluster/settings" -d '
{
    "persistent": {
        "cluster.routing.allocation.allow_rebalance": "indices_all_active",
        "cluster.routing.allocation.disk.watermark.low": "500gb",
        "cluster.routing.allocation.disk.watermark.high": "400gb",
        "cluster.routing.allocation.disk.watermark.flood_stage": "50gb",
        "cluster.info.update.interval": "1m",
        "search.max_buckets": 1000000
    }
}
'

# 清除缓存
/usr/bin/curl --user elastic:elastic -XPOST "http://172.16.0.1:9200/_cache/clear"
echo  "清除缓存"


/usr/bin/curl -H "Content-Type:application/json" --user elastic:elastic -XPUT "http://172.16.0.1:9200/_cluster/settings" -d '
{
    "persistent": {
        "cluster.routing.allocation.allow_rebalance": "indices_all_active",
        "cluster.routing.allocation.disk.watermark.low": "70%",
        "cluster.routing.allocation.disk.watermark.high": "80%",
        "cluster.routing.allocation.disk.watermark.flood_stage": "95%",
        "cluster.info.update.interval": "1m",
        "search.max_buckets": 1000000
    }
}
'