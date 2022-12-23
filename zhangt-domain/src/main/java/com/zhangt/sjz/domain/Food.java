package com.zhangt.sjz.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Food {
	private Integer id;
	private String code;
	private String name;
	private String remark;
	private Integer foodTypeId;
	private Double price;
	private Double oldPrice;
	private Integer isDiscount; // 0：不打折        1：打折
	@JsonIgnore
	private Date createTime;
	@JsonIgnore
	private Date updateTime;
	private String createTimeStr;
	private String updateTimeStr;
	
	private FoodType foodType;
	private List<FoodImg> foodImgs;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
		
		/*
		if (id != null) {
			FoodImgService foodImgService = (FoodImgService) SpringUtil.getBean("foodImgService");
			List<FoodImg> foodImgs = foodImgService.queryFoodImgByFoodId(id);
			if (foodImgs != null && foodImgs.size() > 0) {
				this.foodImgs = foodImgs;
			}
		}*/
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getFoodTypeId() {
		return foodTypeId;
	}
	public void setFoodTypeId(Integer foodTypeId) {
		this.foodTypeId = foodTypeId;
		
		/*
		if (foodTypeId != null) {
			FoodTypeService foodTypeService = (FoodTypeService) SpringUtil.getBean("foodTypeService");
			FoodType foodType1 = foodTypeService.getFoodType(foodTypeId);
			this.foodType = foodType1;
		}*/
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getOldPrice() {
		return oldPrice;
	}
	public void setOldPrice(Double oldPrice) {
		this.oldPrice = oldPrice;
	}
	public Integer getIsDiscount() {
		return isDiscount;
	}
	public void setIsDiscount(Integer isDiscount) {
		this.isDiscount = isDiscount;
	}
	public FoodType getFoodType() {
		return foodType;
	}
	public void setFoodType(FoodType foodType) {
		this.foodType = foodType;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
		if (createTime != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String str = sdf.format(createTime);
			this.createTimeStr = str;
		}
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
		if (updateTime != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String str = sdf.format(updateTime);
			this.updateTimeStr = str;
		}
	}
	public String getCreateTimeStr() {
		return createTimeStr;
	}
	public void setCreateTimeStr(String createTimeStr) {
		this.createTimeStr = createTimeStr;
	}
	public String getUpdateTimeStr() {
		return updateTimeStr;
	}
	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
		
	}
	public List<FoodImg> getFoodImgs() {
		return foodImgs;
	}
	public void setFoodImgs(List<FoodImg> foodImgs) {
		this.foodImgs = foodImgs;
	}
	
}
