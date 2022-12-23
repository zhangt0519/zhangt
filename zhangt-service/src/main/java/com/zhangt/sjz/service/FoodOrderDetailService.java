package com.zhangt.sjz.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhangt.sjz.dao.FoodOrderDetailMapper;
import com.zhangt.sjz.domain.FoodOrderDetail;


@Service
public class FoodOrderDetailService {
	
	@Autowired
	private FoodOrderDetailMapper foodOrderDetailMapper;
	
	public int saveFoodOrderDetail(FoodOrderDetail foodOrderDetail) {
		return foodOrderDetailMapper.insert(foodOrderDetail);
	}
	
	public int updateFoodOrderDetailById(FoodOrderDetail foodOrderDetail) {
		return foodOrderDetailMapper.update(foodOrderDetail);
	}
	
	public int deleteFoodOrderDetailByIds(List<Integer> ids) {
		return foodOrderDetailMapper.delete(ids);
	}
	
	public int queryFoodOrderDetailTotal(FoodOrderDetail foodOrderDetail) {
		return foodOrderDetailMapper.queryTotal(foodOrderDetail);
	}
	
	public List<FoodOrderDetail> queryFoodOrderDetail(FoodOrderDetail foodOrderDetail) {
		return foodOrderDetailMapper.query(foodOrderDetail);
	}
	
	public FoodOrderDetail getFoodOrderDetail(Integer id) {
		return foodOrderDetailMapper.get(id);
	}
	
}
