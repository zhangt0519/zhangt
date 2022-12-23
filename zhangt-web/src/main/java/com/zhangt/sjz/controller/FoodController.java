package com.zhangt.sjz.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.zhangt.sjz.domain.Food;
import com.zhangt.sjz.domain.FoodType;
import com.zhangt.sjz.service.FoodService;

@RestController
@RequestMapping("/food")
public class FoodController {
	@SuppressWarnings("all")
	private static Logger logger = LoggerFactory.getLogger(FoodController.class);

	@Autowired
	private FoodService foodService;


	@RequestMapping(value = "/queryTableData", method = RequestMethod.POST)
	public String queryTableData(HttpServletRequest request) {
		// easyUI的列表分页
		String page = request.getParameter("page"); // 当前页数
		String rows = request.getParameter("rows"); // 每页显示条数

		// 查询参数的值
		String code = request.getParameter("code");
		String name = request.getParameter("name");
		String foodTypeId = request.getParameter("foodTypeId");

		Food food = new Food();
		food.setCode(code);
		food.setName(name);
		if (foodTypeId != null && foodTypeId.trim().length() > 0) {
			food.setFoodTypeId(Integer.parseInt(foodTypeId));
		}

		int total = foodService.queryFoodTotal(food);

		PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(rows)); // 第一个参数：第几页；第二个参数：每页条数
		List<Food> list = foodService.queryFood(food);

		JSONObject json = new JSONObject();
		json.put("total", total);
		json.put("rows", list);
		
		System.out.println(json);

		return json.toString();
	}


	@RequestMapping(value = "/foodDelete", method = RequestMethod.POST)
	public String foodDelete(Integer[] ids) {
		foodService.deleteFoodByIds(Arrays.asList(ids));
		return "删除成功";

	}
	
	@RequestMapping(value = "/foodSave", method = RequestMethod.POST)
	public String foodSave(@RequestBody Food food) {
		if (food.getId() == null) {
			int rst = foodService.saveFood(food);
			
			if (rst > 0) {
				return "新增成功";
			} else {
				return "新增失败";
			}
		} else {
			int rst = foodService.updateFoodById(food);
			
			if (rst > 0) {
				return "修改成功";
			} else {
				return "修改失败";
			}
		}
	}
	
	@RequestMapping(value = "/getAllFood", method = {RequestMethod.POST, RequestMethod.GET})
	public List<Food> getAllFood() {
		List<Food> list = foodService.queryFood(null);
		return list;
	}
	
	@RequestMapping(value = "/getAllFoodByFoodType", method = {RequestMethod.POST, RequestMethod.GET})
	public Map<String, List<Food>> getAllFoodByFoodType() {
		Map<String, List<Food>> rstMap = new HashMap<String, List<Food>>();
		
		List<Food> list = foodService.queryFood(null);
		
		for (Food food : list) {
			FoodType foodType = food.getFoodType();
			if (rstMap.containsKey(foodType.getName())) {
				List<Food> foodList = rstMap.get(foodType.getName());
				foodList.add(food);
			} else {
				List<Food> tempList = new ArrayList<Food>();
				tempList.add(food);
				rstMap.put(foodType.getName(), tempList);
			}
		}
		
		return rstMap;
	}
	
}
