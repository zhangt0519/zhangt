package com.zhangt.sjz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhangt.sjz.dao.FoodMapper;
import com.zhangt.sjz.dao.FoodTypeMapper;
import com.zhangt.sjz.domain.Food;
import com.zhangt.sjz.domain.FoodType;


@Service
public class FoodService {
	
	@Autowired
	private FoodMapper foodMapper;
	
	@Autowired
	private FoodTypeMapper foodTypeMapper;
	
	public int saveFood(Food food) {
		return foodMapper.insert(food);
	}
	
	public int updateFoodById(Food food) {
		return foodMapper.update(food);
	}
	
	public int deleteFoodByIds(List<Integer> ids) {
		return foodMapper.delete(ids);
	}
	
	public int queryFoodTotal(Food food) {
		return foodMapper.queryTotal(food);
	}
	
	public List<Food> queryFood(Food food) {
		List<Food> foodList = foodMapper.query(food);
		
		for (Food item : foodList) {
			FoodType foodType1 = foodTypeMapper.get(item.getFoodTypeId());
			item.setFoodType(foodType1);
		}
		
		return foodList;
	}
	
	public Food getFood(Integer id) {
		return foodMapper.get(id);
	}
	
}
