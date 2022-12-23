package com.zhangt.sjz;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@ComponentScan(basePackages = { "com.zhangt.sjz", "springboot" })
@MapperScan(basePackages = { "com.zhangt.sjz" }) // 告诉mapper所在的包名
@EnableScheduling
@ServletComponentScan(basePackages = "com.zhangt.sjz.filter")
public class AppBoot extends SpringBootServletInitializer {
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(AppBoot.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(AppBoot.class, args);
	}
}

