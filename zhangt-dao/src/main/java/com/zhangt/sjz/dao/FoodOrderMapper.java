package com.zhangt.sjz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.zhangt.sjz.domain.FoodOrder;



@Mapper
public interface FoodOrderMapper {
	
	public int insert(FoodOrder foodOrder);
	
	public int update(FoodOrder foodOrder);
	
	public int queryTotal(FoodOrder foodOrder);
	
	public List<FoodOrder> query(FoodOrder foodOrder);
	
	public int delete(List<Integer> list);
	
	@Select("select id,tel,order_price orderPrice,is_done isDone,create_time createTime,update_time updateTime from food_order where id=#{id}")
	public FoodOrder get(Integer id);
	
}
