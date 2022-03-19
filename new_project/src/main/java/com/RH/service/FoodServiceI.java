package com.RH.service;

import com.RH.db.pojo.Food;
import com.RH.db.pojo.Food_Type;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface FoodServiceI {


    public List<Food> selectAllFoodByLimits();

    public int deleteFoodById(String fid);

    public List<Food_Type> selectFoodTyprByLimits();

    public int updateFoodById(String fid,String jsonStr);

    public int uploadFood(MultipartFile foodImg, Food food, HttpServletRequest request);
}
