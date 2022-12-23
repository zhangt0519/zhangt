package com.zhangt.sjz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhangt.sjz.dao.FoodOrderMapper;
import com.zhangt.sjz.domain.FoodOrder;


@Service
public class FoodOrderService {
	
	@Autowired
	private FoodOrderMapper foodOrderMapper;
	
	public int saveFoodOrder(FoodOrder foodOrder) {
		return foodOrderMapper.insert(foodOrder);
	}
	
	public int updateFoodOrderById(FoodOrder foodOrder) {
		return foodOrderMapper.update(foodOrder);
	}
	
	public int deleteFoodOrderByIds(List<Integer> ids) {
		return foodOrderMapper.delete(ids);
	}
	
	public int queryFoodOrderTotal(FoodOrder foodOrder) {
		return foodOrderMapper.queryTotal(foodOrder);
	}
	
	public List<FoodOrder> queryFoodOrder(FoodOrder foodOrder) {
		return foodOrderMapper.query(foodOrder);
	}
	
	public FoodOrder getFoodOrder(Integer id) {
		return foodOrderMapper.get(id);
	}
	
}
