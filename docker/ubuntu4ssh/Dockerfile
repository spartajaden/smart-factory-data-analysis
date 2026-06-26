# 1. 원본 우분투를 베이스로 시작합니다
FROM ubuntu:22.04

# 2. 설치 도중 사용자 입력을 요구하는 창 방지
ENV DEBIAN_FRONTEND=noninteractive

# 3. 우분투 업데이트 + OpenJDK 17 + Maven + 컨테이너 유지용 유틸리티(ssh 등) 설치
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    maven \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# 4. 컨테이너가 켜지자마자 강제로 무한 대기하며 켜져 있게 만드는 설정
# (이게 없으면 컨테이너가 실행되자마자 바로 꺼집니다!)
CMD ["tail", "-f", "/dev/null"]

