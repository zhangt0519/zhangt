package com.zhangt.sjz.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.zhangt.sjz.domain.User;


@RestController
public class UserController {
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "/user/login", method = RequestMethod.POST)
	public String userLogin(HttpServletRequest request, String code, String pwd, String rand) {
		
		logger.info("user login------------------------->");
		
		String randSaved = request.getSession().getAttribute("code").toString();
		if (!randSaved.equalsIgnoreCase(rand)) {

			return "验证码错误";
		}
		
		if ("admin".equals(code) && "admin".equals(pwd)) {
			User user = new User();
			
			user.setCode(code);
			user.setName(code);

			request.getSession().setAttribute("user", user);
			
			return "ok";
		} else {
			return "用户名或密码错误";
		}

	}

}
