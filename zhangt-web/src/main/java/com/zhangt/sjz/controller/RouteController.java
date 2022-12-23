package com.zhangt.sjz.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.zhangt.sjz.domain.Food;
import com.zhangt.sjz.domain.FoodType;
import com.zhangt.sjz.service.FoodService;
import com.zhangt.sjz.service.FoodTypeService;


@Controller
public class RouteController {
	
	@Autowired
	private FoodTypeService foodTypeService;
	
	@Autowired
	private FoodService foodService;

	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToLogin() {
		return "login/login";
	}
	
	@RequestMapping(value = "/foodType", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodType() {
		return "/foodtype/foodType";
	}
	
	@RequestMapping(value = "/foodTypeAdd", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodTypeAdd(Integer id, HttpServletRequest request) {
		if (id != null) {
			FoodType foodType = foodTypeService.getFoodType(id);
			request.setAttribute("foodType", foodType);
		}

		return "/foodtype/add";
	}
	
	@RequestMapping(value = "/foodOrder", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodOrder() {
		return "/foodorder/foodOrder";
	}
	
	@RequestMapping(value = "/foodOrderDetail", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodOrderDetail() {
		return "/foodorderdetail/foodOrderDetail";
	}
	
	@RequestMapping(value = "/food", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFood() {
		return "/food/food";
	}
	
	@RequestMapping(value = "/foodAdd", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodAdd(Integer id, HttpServletRequest request) {
		if (id != null) {
			Food food = foodService.getFood(id);
			request.setAttribute("food", food);
		}

		return "/food/add";
	}
	
	@RequestMapping(value = "/foodImg", method = { RequestMethod.GET, RequestMethod.POST })
	public String goToFoodImg(Integer foodId, HttpServletRequest request) {
		Food food = foodService.getFood(foodId);
		request.setAttribute("food", food);
		return "/food/foodImg";
	}
	
}
