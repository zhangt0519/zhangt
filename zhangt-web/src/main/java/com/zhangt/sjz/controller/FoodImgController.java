package com.zhangt.sjz.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.zhangt.sjz.domain.FoodImg;
import com.zhangt.sjz.service.FoodImgService;

@RestController
@RequestMapping("/foodImg")
public class FoodImgController {
	@SuppressWarnings("all")
	private static Logger logger = LoggerFactory.getLogger(FoodImgController.class);
	
	@Value("${food_img_base}")
	private String foodImgBase;
	
	@Value("${food_img_url}")
	private String foodImgUrl;

	@Autowired
	private FoodImgService foodImgService;


	@RequestMapping(value = "/queryTableData", method = RequestMethod.POST)
	public String queryTableData(HttpServletRequest request) {
		// easyUI的列表分页
		String page = request.getParameter("page"); // 当前页数
		String rows = request.getParameter("rows"); // 每页显示条数

		// 查询参数的值
		String foodId = request.getParameter("foodId");

		FoodImg foodImg = new FoodImg();
		if (foodId != null && foodId.trim().length() > 0) {
			foodImg.setFoodId(Integer.parseInt(foodId));
		}

		int total = foodImgService.queryFoodImgTotal(foodImg);

		PageHelper.startPage(Integer.parseInt(page), Integer.parseInt(rows)); // 第一个参数：第几页；第二个参数：每页条数
		List<FoodImg> list = foodImgService.queryFoodImg(foodImg);

		JSONObject json = new JSONObject();
		json.put("total", total);
		json.put("rows", list);
		
		logger.info(json.toString());

		return json.toString();
	}


	@RequestMapping(value = "/foodImgDelete", method = RequestMethod.POST)
	public String foodImgDelete(Integer[] ids) {
		foodImgService.deleteFoodImgByIds(Arrays.asList(ids));
		return "删除成功";

	}
	
	@RequestMapping(value = "/foodImgTop", method = RequestMethod.POST)
	public String foodTop(Integer id) {
		FoodImg foodImg = new FoodImg();
		foodImg.setId(id);
		foodImgService.updateFoodImgById(foodImg);
		return "置顶成功";

	}
	
	@RequestMapping(value = "/upload", headers = "content-type=multipart/*", method = RequestMethod.POST) 
    public String upload(@RequestParam("file") MultipartFile file, @RequestParam("fileName") String newFileName, @RequestParam("foodId") Integer foodId) {
		// String fileName = file.getOriginalFilename(); 
		// String filePath = "d:\\sjzszd\\tempfile\\";
		String filePath = this.foodImgBase;
		File dest = new File(filePath + newFileName);
		 
		try { 
			file.transferTo(dest); 
		} catch (IOException e) {
			logger.error("图片上传异常：", e);
			e.printStackTrace(); 
		}
		
		FoodImg foodImg = new FoodImg();
		foodImg.setFoodId(foodId);
		foodImg.setImgName(newFileName);
		foodImg.setImgUrl(this.foodImgUrl + newFileName);
		
		int rst = foodImgService.saveFoodImg(foodImg);
		
		if (rst > 0) {
			return "新增图片成功";
		} else {
			return "新增图片失败";
		}
    }

}
