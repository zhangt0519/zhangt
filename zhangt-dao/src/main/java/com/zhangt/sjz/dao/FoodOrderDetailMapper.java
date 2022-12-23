package com.zhangt.sjz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.zhangt.sjz.domain.FoodOrderDetail;



@Mapper
public interface FoodOrderDetailMapper {
	
	public int insert(FoodOrderDetail foodOrderDetail);
	
	public int update(FoodOrderDetail foodOrderDetail);
	
	public int queryTotal(FoodOrderDetail foodOrderDetail);
	
	public List<FoodOrderDetail> query(FoodOrderDetail foodOrderDetail);
	
	public int delete(List<Integer> list);
	
	@Select("select id,order_id orderId,food_id foodId,food_count foodCount,detail_price detailPrice,create_time createTime,update_time updateTime from food_order where id=#{id}")
	public FoodOrderDetail get(Integer id);
	
}
