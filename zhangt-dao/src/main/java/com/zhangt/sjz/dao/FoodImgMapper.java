package com.zhangt.sjz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.zhangt.sjz.domain.FoodImg;



@Mapper
public interface FoodImgMapper {
	
	public int insert(FoodImg foodImg);
	
	public int update(FoodImg foodImg);
	
	public int queryTotal(FoodImg foodImg);
	
	public List<FoodImg> query(FoodImg foodImg);
	
	public int delete(List<Integer> list);
	
	@Select("select id,food_id foodId,img_name imgName,img_url imgUrl,create_time createTime,update_time updateTime from food_img where id=#{id}")
	public FoodImg get(Integer id);
	
}
