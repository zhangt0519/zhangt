package com.zhangt.sjz.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.zhangt.sjz.domain.FoodOrder;
import com.zhangt.sjz.service.FoodOrderService;

@RestController
@RequestMapping("/foodOrder")
public class FoodOrderController {
	@SuppressWarnings("all")
	private static Logger logger = LoggerFactory.getLogger(FoodOrderController.class);

	@Autowired
	private FoodOrderService foodOrderService;


	@RequestMapping(value = "/queryTableData", method = RequestMethod.POST)
	public String queryTableData(HttpServletRequest request) {
		// easyUI的列表分页
		String page = request.getParameter("page"); // 当前页数
		String rows = request.getParameter("rows"); // 每页显示条数

		// 查询参数的值
		String isDone = request.getParameter("isDone");
		String tel = request.getParameter("tel");
		String startTimeStr = request.getParameter("startTimeStr");
		String endTimeStr = request.getParameter("endTimeStr");

		FoodOrder foodOrder = new FoodOrder();
		if (isDone != null && isDone.trim().length() > 0) {
			foodOrder.setIsDone(Integer.parseInt(isDone));
		}
		foodOrder.setTel(tel);
		foodOrder.setStartTimeStr(startTimeStr);
		foodOrder.setEndTimeStr(endTimeStr);

		int total = foodOrderService.queryFoodOrderTotal(foodOrder);

		PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(rows)); // 第一个参数：第几页；第二个参数：每页条数
		List<FoodOrder> list = foodOrderService.queryFoodOrder(foodOrder);

		JSONObject json = new JSONObject();
		json.put("total", total);
		json.put("rows", list);

		return json.toString();
	}


	@RequestMapping(value = "/foodOrderDelete", method = RequestMethod.POST)
	public String foodOrderDelete(Integer[] ids) {
		foodOrderService.deleteFoodOrderByIds(Arrays.asList(ids));
		return "删除成功";

	}
	
	@RequestMapping(value = "/foodOrderDone", method = RequestMethod.POST)
	public String foodOrderDone(Integer id) {
		FoodOrder foodOrder = new FoodOrder();
		foodOrder.setId(id);
		foodOrder.setIsDone(1);
		foodOrderService.updateFoodOrderById(foodOrder);
		return "操作成功";

	}
	
}
