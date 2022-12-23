package com.zhangt.sjz.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
	
	private static Logger logger = LoggerFactory.getLogger(HelloController.class);
	
	@RequestMapping("/hello/test1")
	public String test1() {
		
		logger.info("hello hello hello hello hello hello hello -------------->");

		return "test1!";
	}

}
