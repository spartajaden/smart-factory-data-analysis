FROM ubuntu:22.04
LABEL maintainer="JH cjaehwa385@gmail.com"
RUN apt update &&\
    apt upgrade -y &&\
    apt install -y sudo passwd openssh-server curl wget nano net-tools iputils-ping openjdk-8-jdk python3-pip &&\
    apt clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    groupadd pkdata &&\
    useradd -m -d /home/pkdata -s /bin/bash -g pkdata -G sudo pkdata &&\
    echo "pkdata:1234" | chpasswd &&\   
    mkdir -p /home/pkdata/.ssh &&\
    chown -R pkdata:pkdata /home/pkdata
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/pkdata/.bashrc &&\
    chown pkdata:pkdata /home/pkdata/.bashrc &&\
    mkdir -p /var/run/sshd &&\
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config &&\
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config   

# NodeSource 스크립트로 최신 LTS Node.js 설치
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

# npm 최신 버전으로 업데이트
RUN npm install -g npm@latest

ENV PATH="/home/pkdata/.local/bin:$PATH"

CMD ["/bin/bash","-c","service ssh start&& exec /bin/bash"]


