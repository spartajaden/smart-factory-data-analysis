#!/bin/bash

# SSH 서비스 시작 후 안정적인 구동을 위해 1초 대기
service ssh start
sleep 1

if [ "$ROLE" = "namenode" ]; then
    echo "Starting NameNode..."
    if [ ! -d "/opt/hadoop/data/namenode/current" ]; then
        echo "Formatting NameNode..."
        $HADOOP_HOME/bin/hdfs namenode -format -force -nonInteractive
    fi
    
    $HADOOP_HOME/bin/hdfs --daemon start namenode
    $HADOOP_HOME/bin/yarn --daemon start resourcemanager
    echo "NameNode & ResourceManager services started."

elif [ "$ROLE" = "datanode" ]; then
    echo "Starting DataNode..."
    $HADOOP_HOME/bin/hdfs --daemon start datanode
    $HADOOP_HOME/bin/yarn --daemon start nodemanager
    echo "DataNode & NodeManager services started."
fi

tail -f /dev/null