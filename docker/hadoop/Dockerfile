FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. 시스템 패키지, JDK 설치 및 SSH 디렉토리 사전 준비
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk ssh rsync wget curl sudo && \
    mkdir /var/run/sshd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV HADOOP_VERSION=3.3.6
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# 2. Hadoop 다운로드 및 설치
RUN wget -q https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ && \
    mv /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

# 3. SSH 설정 (절대 경로 지정 및 호스트 키 생성 보안 강화)
RUN mkdir -p /root/.ssh && \
    ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config

# 4. 설정 파일 복사
COPY config/* ${HADOOP_HOME}/etc/hadoop/
COPY scripts/start-hadoop.sh /opt/start-hadoop.sh

RUN chmod +x /opt/start-hadoop.sh

WORKDIR ${HADOOP_HOME}

CMD ["/opt/start-hadoop.sh"]