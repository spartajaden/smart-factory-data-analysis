package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController // 👈 웹 브라우저에서 접속했을 때 글자를 보여주게 만드는 마법의 문구
public class App {

    // 브라우저로 접속했을 때 화면에 보여줄 메시지 설정
    @GetMapping("/")
    public String home() {
        return "<h1>안녕하세요! PK01 컨테이너의 Spring Boot 서버입니다!</h1>";
    }

    // 스프링 부트 웹 서버를 가동시키는 메인 메서드
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}

