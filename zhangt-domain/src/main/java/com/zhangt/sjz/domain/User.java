package com.zhangt.sjz.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {
	private Integer id;
	private String code;
	private String name;
	private String pwd;
	private Integer flag;
	private String mobile;
	private Date lastUpdateDate;
	private String lastUpdateDateStr;
	private Integer loginErrors;
	private Date lastLoginDate;
	private String lastLoginDateStr;
	private String groupCode;
	private Integer type;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}
	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
		if (lastUpdateDate != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String str = sdf.format(lastUpdateDate);
			this.lastUpdateDateStr = str;
		}
	}
	public Integer getLoginErrors() {
		return loginErrors;
	}
	public void setLoginErrors(Integer loginErrors) {
		this.loginErrors = loginErrors;
	}
	public Date getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
		if (lastLoginDate != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String str = sdf.format(lastLoginDate);
			this.lastLoginDateStr = str;
		}
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getLastUpdateDateStr() {
		return lastUpdateDateStr;
	}
	public void setLastUpdateDateStr(String lastUpdateDateStr) {
		this.lastUpdateDateStr = lastUpdateDateStr;
	}
	
	public String getLastLoginDateStr() {
		return lastLoginDateStr;
	}
	public void setLastLoginDateStr(String lastLoginDateStr) {
		this.lastLoginDateStr = lastLoginDateStr;
	}
	public User() {}
	
	public User(Integer flag, String groupCode, String code, String name, String pwd, String mobile, Integer type) {
		this.flag = flag;
		this.groupCode = groupCode;
		this.code = code;
		this.name = name;
		this.pwd = pwd;
		this.mobile = mobile;
		this.type = type;
	}
	

}
