#!/bin/sh

# 在es启动后，设置自定义模板，可修改主副分片数量。

while true
do
    http_code=$(curl -m 5 -s -o /dev/null -w '%{http_code}' http://elasticsearch.elastic.svc:9200)
    if [[ "$http_code" = 200 ]]; then
        echo ">>>elasticsearch ready, put template."
        res=$(curl -m 10 -s -o /dev/null -w '%{http_code}' -XPUT -d '{"template":"filebeat*","settings":{"number_of_shards":2}}'  http://elasticsearch.elastic.svc:9200/_template/filebeat-template)
        if [[ "$res" = 200 ]]; then
            echo ">>>put template success."
        else
            echo ">>>put template failed."
        fi
    break
    else
        echo ">>>elasticsearch not ready, sleep 10 seconds."
        sleep 10
    fi
done
