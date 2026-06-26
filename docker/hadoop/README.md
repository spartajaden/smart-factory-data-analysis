# Hadoop Docker 분산처리 클러스터 실습

이 프로젝트는 학생들이 Hadoop 분산처리 시스템을 로컬 PC에서 쉽게 실습할 수 있도록 구성된 Docker 기반 클러스터입니다.
(NameNode 1대 + DataNode 3대 구성)

## 1. 사전 준비
- [Docker Desktop](https://www.docker.com/products/docker-desktop)이 설치되어 있어야 합니다.
- (Windows 사용자) 관리자 권한으로 `setup-hosts.ps1` 스크립트를 실행하여 hosts 파일을 설정하세요. 이렇게 하면 브라우저에서 `namenode` 호스트 이름으로 바로 접근할 수 있습니다.

## 2. 클러스터 시작
터미널(또는 명령 프롬프트)을 열고, 프로젝트 폴더에서 아래 명령어를 실행합니다.

```bash
# 이미지 빌드 및 백그라운드 실행
docker-compose up -d --build
```

실행 후 잠시 기다렸다가, 웹 브라우저에서 아래 주소로 접속해 클러스터 상태를 확인합니다.
- HDFS Web UI: [http://localhost:9870](http://localhost:9870)
- YARN Web UI: [http://localhost:8088](http://localhost:8088)

## 3. 실습 예제: HDFS 파일 업로드 및 WordCount

### HDFS 명령어 실습
NameNode 컨테이너에 접속하여 HDFS 명령어를 실습합니다.

```bash
# NameNode 컨테이너 접속
docker exec -it namenode bash

# HDFS 사용자 디렉토리 생성
hdfs dfs -mkdir -p /user/student

# 로컬에 샘플 파일 생성
echo "hello hadoop docker hadoop" > sample.txt

# HDFS에 파일 업로드
hdfs dfs -put sample.txt /user/student/

# HDFS 파일 목록 확인
hdfs dfs -ls /user/student
```

### WordCount MapReduce 실습
하둡에 내장된 예제 jar 파일을 이용해 WordCount를 실행해봅니다.

```bash
# WordCount 예제 실행
yarn jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar wordcount /user/student/sample.txt /user/student/output

# 결과 확인
hdfs dfs -cat /user/student/output/part-r-00000
```

## 4. 클러스터 종료 및 초기화

실습이 끝난 후 클러스터를 종료하려면 아래 명령어를 사용합니다.

```bash
# 클러스터 종료 (데이터는 유지됨)
docker-compose down

# 클러스터 종료 및 데이터 완전 삭제 (초기화)
docker-compose down -v
```

## 5. 트러블슈팅
- **메모리 부족**: PC 메모리가 부족하여 컨테이너가 종료된다면, `docker-compose.yml` 파일에서 각 컨테이너의 `mem_limit` 값을 적절히 조절하세요.
- **포트 충돌**: 9870, 8088, 9000 포트가 이미 사용 중이라면, `docker-compose.yml` 파일에서 앞쪽 포트 번호를 변경하여 실행하세요. (예: `9871:9870`)
