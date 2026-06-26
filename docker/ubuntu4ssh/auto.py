import yaml

class IndentDumper(yaml.Dumper):
    def increase_indent(self, flow=False, indentless=False):
        return super(IndentDumper, self).increase_indent(flow, False)

def generate_docker_compose():
    total_containers = 12
    compose_data = {
        "version": "3.8",
        "services": {}
    }

    for i in range(1, total_containers + 1):
        num_str = f"{i:02d}"
        service_name = f"pkuser{num_str}"
        hostname = f"PK{num_str}"
        port_mapping = f"{2200 + i}:22" 
        
        compose_data["services"][service_name] = {
            "image": "pkteam:1.0",
            "hostname": hostname,
            "ports": [port_mapping],
            "restart": "unless-stopped",
            "tty": True,  # 👈 'command'를 제거하고 'tty: true'를 넣어 컨테이너가 죽지 않게 만듭니다.
            "volumes": [
                f"D:/data/container_ssh/{service_name}:/home/pkuser/data"
            ]
        }

    output_filename = "docker-compose.yml"
    with open(output_filename, "w", encoding="utf-8") as f:
        yaml.dump(compose_data, f, Dumper=IndentDumper, default_flow_style=False, sort_keys=False)
        
    print(f"✨ 에러가 해결된 {output_filename} 파일이 새로 생성되었습니다!")

if __name__ == "__main__":
    generate_docker_compose()