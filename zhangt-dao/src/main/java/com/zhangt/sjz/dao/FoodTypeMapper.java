package com.zhangt.sjz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.zhangt.sjz.domain.FoodType;



@Mapper
public interface FoodTypeMapper {
	
	public int insert(FoodType foodType);
	
	public int update(FoodType foodType);
	
	public int queryTotal(FoodType foodType);
	
	public List<FoodType> query(FoodType foodType);
	
	public int delete(List<Integer> list);
	
	@Select("select id,code,name,create_time createTime,update_time updateTime from food_type where id=#{id}")
	public FoodType get(Integer id);
	
}
