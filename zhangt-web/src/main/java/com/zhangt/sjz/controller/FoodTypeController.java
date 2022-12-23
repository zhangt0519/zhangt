package com.zhangt.sjz.controller;

import java.util.Arrays;
import java.util.List;

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
import com.zhangt.sjz.domain.FoodType;
import com.zhangt.sjz.service.FoodTypeService;

@RestController
@RequestMapping("/foodType")
public class FoodTypeController {
	@SuppressWarnings("all")
	private static Logger logger = LoggerFactory.getLogger(FoodTypeController.class);

	@Autowired
	private FoodTypeService foodTypeService;


	@RequestMapping(value = "/queryTableData", method = RequestMethod.POST)
	public String queryTableData(HttpServletRequest request) {
		// easyUI的列表分页
		String page = request.getParameter("page"); // 当前页数
		String rows = request.getParameter("rows"); // 每页显示条数

		// 查询参数的值
		String code = request.getParameter("code");
		String name = request.getParameter("name");

		FoodType foodType = new FoodType();
		foodType.setCode(code);
		foodType.setName(name);

		int total = foodTypeService.queryFoodTypeTotal(foodType);

		PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(rows)); // 第一个参数：第几页；第二个参数：每页条数
		List<FoodType> list = foodTypeService.queryFoodType(foodType);

		JSONObject json = new JSONObject();
		json.put("total", total);
		json.put("rows", list);

		return json.toString();
	}


	@RequestMapping(value = "/foodTypeDelete", method = RequestMethod.POST)
	public String foodTypeDelete(Integer[] ids) {
		foodTypeService.deleteFoodTypeByIds(Arrays.asList(ids));
		return "删除成功";

	}
	
	@RequestMapping(value = "/foodTypeSave", method = RequestMethod.POST)
	public String foodTypeSave(@RequestBody FoodType foodType) {
		if (foodType.getId() == null) {
			int rst = foodTypeService.saveFoodType(foodType);
			
			if (rst > 0) {
				return "新增成功";
			} else {
				return "新增失败";
			}
		} else {
			int rst = foodTypeService.updateFoodTypeById(foodType);
			
			if (rst > 0) {
				return "修改成功";
			} else {
				return "修改失败";
			}
		}
	}
	
	@RequestMapping(value = "/getAllFoodType", method = {RequestMethod.POST, RequestMethod.GET})
	public List<FoodType> getAllFoodType() {
		List<FoodType> foodTypes = foodTypeService.queryFoodType(null);
		return foodTypes;
	}

}
