package com.RH.controller;

import com.RH.db.pojo.Food;
import com.RH.db.pojo.Food_Type;
import com.RH.service.FoodServiceI;
import com.RH.utils.ResultMap;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class FoodController {

    @Autowired
    private FoodServiceI foodServiceI;
    @Autowired
    private ResultMap resultMap;

    @RequestMapping("/selectFoodType")
    @ResponseBody
    public ResultMap selectAllType() {
        try {
            List<Food_Type> list = foodServiceI.selectFoodTyprByLimits();
            resultMap.setStatus(true);
            resultMap.setList(list);
        } catch (Exception e) {
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }



    @RequestMapping("/selectAllFoodByLimits")
    @ResponseBody
    public ResultMap selectAllFoodByLimits(int page,int limit){
        try{
            PageHelper.startPage(page, limit);//开启分页
            List<Food> list=foodServiceI.selectAllFoodByLimits();
            PageInfo<Food> pageInfo=new PageInfo<Food>(list);
            long total=pageInfo.getTotal();
            resultMap.setCode(0);
            resultMap.setList(list);
            resultMap.setTotal(total);
        }catch (Exception e){
            resultMap.setCode(1);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }


    @RequestMapping("/deleteFoodById")
    @ResponseBody
    public ResultMap deleteUserById(String fid){
        try{
            foodServiceI.deleteFoodById(fid);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }


    @RequestMapping("/updateFoodById")
    @ResponseBody
    public ResultMap updateFoodById(String fid,String jsonStr){
        try{
            foodServiceI.updateFoodById(fid,jsonStr);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

    @RequestMapping("/uploadFood")
    public String uploadFood(MultipartFile ImgFile, Food food, HttpServletRequest request){
        try {
            foodServiceI.uploadFood(ImgFile,food,request);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "FoodMananger";
    }
}
