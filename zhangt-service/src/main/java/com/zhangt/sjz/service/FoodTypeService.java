package com.zhangt.sjz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhangt.sjz.dao.FoodTypeMapper;
import com.zhangt.sjz.domain.FoodType;


@Service
public class FoodTypeService {
	
	@Autowired
	private FoodTypeMapper foodTypeMapper;
	
	public int saveFoodType(FoodType foodType) {
		return foodTypeMapper.insert(foodType);
	}
	
	public int updateFoodTypeById(FoodType foodType) {
		return foodTypeMapper.update(foodType);
	}
	
	public int deleteFoodTypeByIds(List<Integer> ids) {
		return foodTypeMapper.delete(ids);
	}
	
	public int queryFoodTypeTotal(FoodType foodType) {
		return foodTypeMapper.queryTotal(foodType);
	}
	
	public List<FoodType> queryFoodType(FoodType foodType) {
		return foodTypeMapper.query(foodType);
	}
	
	public FoodType getFoodType(Integer id) {
		return foodTypeMapper.get(id);
	}
	
}
