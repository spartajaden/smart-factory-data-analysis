# JAVA_HOME 환경변수 설정
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
# Hadoop 힙 메모리 설정 (학생 PC 고려)
export HADOOP_HEAPSIZE_MAX=256
export HADOOP_HEAPSIZE_MIN=256
# 기타 설정
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
