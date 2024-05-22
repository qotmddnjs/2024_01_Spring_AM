package com.example.demo;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**") // 해당 URL 패턴에 대해 CORS를 허용합니다.
                .allowedOrigins("*") // 모든 오리진에서의 요청을 허용합니다. 필요에 따라 특정 오리진만 허용할 수도 있습니다.
                .allowedMethods("GET", "POST") // 허용할 HTTP 메서드를 지정합니다.
                .allowCredentials(true); // 인증 정보를 요청에 포함할지 여부를 지정합니다.
    }
}
