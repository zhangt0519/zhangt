package com.zhangt.sjz.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.zhangt.sjz.domain.Food;
import com.zhangt.sjz.domain.FoodOrder;
import com.zhangt.sjz.domain.FoodOrderDetail;
import com.zhangt.sjz.service.FoodOrderDetailService;
import com.zhangt.sjz.service.FoodOrderService;
import com.zhangt.sjz.service.FoodService;

@RestController
@RequestMapping("/foodOrderDetail")
public class FoodOrderDetailController {
	@SuppressWarnings("all")
	private static Logger logger = LoggerFactory.getLogger(FoodOrderDetailController.class);

	@Autowired
	private FoodOrderDetailService foodOrderDetailService;
	
	@Autowired
	private FoodOrderService foodOrderService;
	
	@Autowired
	private FoodService foodService;


	@RequestMapping(value = "/queryTableData", method = RequestMethod.POST)
	public String queryTableData(HttpServletRequest request) {
		// easyUI的列表分页
		String page = request.getParameter("page"); // 当前页数
		String rows = request.getParameter("rows"); // 每页显示条数

		// 查询参数的值
		String orderId = request.getParameter("orderId");
		String startTimeStr = request.getParameter("startTimeStr");
		String endTimeStr = request.getParameter("endTimeStr");

		FoodOrderDetail foodOrderDetail = new FoodOrderDetail();
		if (orderId != null && orderId.trim().length() > 0) {
			foodOrderDetail.setOrderId(Integer.parseInt(orderId));
		}
		foodOrderDetail.setStartTimeStr(startTimeStr);
		foodOrderDetail.setEndTimeStr(endTimeStr);

		int total = foodOrderDetailService.queryFoodOrderDetailTotal(foodOrderDetail);

		PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(rows)); // 第一个参数：第几页；第二个参数：每页条数
		List<FoodOrderDetail> list = foodOrderDetailService.queryFoodOrderDetail(foodOrderDetail);

		JSONObject json = new JSONObject();
		json.put("total", total);
		json.put("rows", list);

		return json.toString();
	}

	@SuppressWarnings("all")
	@RequestMapping(value = "/generateOrder", method = RequestMethod.POST)
	@Transactional
	public String generateOrder(@RequestBody Map[] map) {
		logger.info("map", map);
		
		if (map != null && map.length > 0) {
			String tel = map[0].get("phone") + "";
			
			FoodOrder foodOrder = new FoodOrder();
			foodOrder.setTel(tel);
			
			foodOrderService.saveFoodOrder(foodOrder);
			Integer foodOrderId = foodOrder.getId();
			
			Double totalPrice = 0.0;
			for (Map item : map) {
				Integer foodId = Integer.parseInt(item.get("id") + "");
				String foodName = item.get("name") + "";
				Integer foodCount = Integer.parseInt(item.get("count") + "");
				
				FoodOrderDetail foodOrderDetail = new FoodOrderDetail();
				foodOrderDetail.setOrderId(foodOrderId);
				foodOrderDetail.setFoodId(foodId);
				foodOrderDetail.setFoodCount(foodCount);
				
				Food food = foodService.getFood(foodId);
				foodOrderDetail.setFoodName(food.getName());
				foodOrderDetail.setFoodPrice(food.getPrice());
				foodOrderDetail.setDetailPrice(foodCount * food.getPrice());
				
				foodOrderDetailService.saveFoodOrderDetail(foodOrderDetail);
				
				totalPrice += foodOrderDetail.getDetailPrice();
			}
			
			FoodOrder updateFoodOrder = new FoodOrder();
			updateFoodOrder.setId(foodOrderId);
			updateFoodOrder.setOrderPrice(totalPrice);
			foodOrderService.updateFoodOrderById(updateFoodOrder);
			
		}
		
		return "added success";
	}
}
