package com.zhangt.sjz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.zhangt.sjz.domain.Food;



@Mapper
public interface FoodMapper {
	
	public int insert(Food food);
	
	public int update(Food food);
	
	public int queryTotal(Food food);
	
	public List<Food> query(Food food);
	
	public int delete(List<Integer> list);
	
	@Select("select id,code,name,remark,food_type_id foodTypeId,price,old_price oldPrice,is_discount isDiscount,create_time createTime,update_time updateTime from food where id=#{id}")
	public Food get(Integer id);
	
}
