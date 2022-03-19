package com.RH.service;


import com.RH.db.dao.FoodDao;
import com.RH.db.pojo.Food;
import com.RH.db.pojo.Food_Type;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class FoodServiceImpl implements FoodServiceI{

    @Autowired
    private FoodDao foodDao;

    @Override
    public List<Food> selectAllFoodByLimits() {
        return foodDao.selectAllFoodByLimits();
    }

    @Override
    public int deleteFoodById(String fid) {
        if (fid.equals("")){
            throw new RuntimeException("无菜品！");
        }
        int Intfid = Integer.parseInt(fid);
        int num=foodDao.deleteFoodById(Intfid);
        if(num==0){
            throw new RuntimeException("删除失败！");
        }

        num=foodDao.deleteFoodTById(Intfid);
        if(num==0){
            throw new RuntimeException("删除种类失败！");
        }
        return num;
    }

    @Override
    public List<Food_Type> selectFoodTyprByLimits() {
        return foodDao.selectFoodTyprByLimits();
    }

    @Override
    public int updateFoodById(String fid, String jsonStr) {
        Food food = JSON.parseObject(jsonStr,Food.class);
        int Intfid = Integer.parseInt(fid);
        food.setFid(Intfid);
        int num=foodDao.updateFood(food);
        if(num==0){
            throw new RuntimeException("菜品信息修改失败！");
        }
        num=foodDao.updateFoodtype(food);
        if(num==0){
            throw new RuntimeException("菜品种类修改失败！");
        }
        return num;
    }

    @Override
    public int uploadFood(MultipartFile foodImg, Food food, HttpServletRequest request) {
        Map<String,String> map = uploadVideoAndImg(foodImg,request);
        return insertFood(food,map);
    }


    private Map<String,String> uploadVideoAndImg(MultipartFile ImgFile, HttpServletRequest request) {
        //图片文件原名称
        String foodImgName = ImgFile.getOriginalFilename();
        //得到图片的后缀名
        String imgFileExtension = foodImgName.substring(foodImgName.lastIndexOf("."));
        //生成新得图片名称: 因为上传的文件可能重名
        String newfoodImgName = UUID.randomUUID().toString()+imgFileExtension;

        //获得图片要上传到服务器的路径
        String imgServerPath = request.getServletContext().getRealPath("/")+"images/"+newfoodImgName;

        //创建图片目标目录
        File targetImgFile = new File(imgServerPath);
        //创建视频目标目录

        //向map中存值: 视频原名称、视频相对路径、图片相对路径
        Map<String,String> map = new HashMap<String,String>();
        try {
            ImgFile.transferTo(targetImgFile);//图片上传

            map.put("imgFileName", foodImgName);

            //获得图片相对路径: 存入到数据库中
            String imgRelativePath = request.getServletContext().getContextPath()+"/images/"+newfoodImgName;
            //获得视频相对路径: 存入到数据库中

            map.put("imgRelativePath", imgRelativePath);

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }

    private int insertFood(Food food,Map<String,String> map) {
        food.setFoodImg(map.get("imgFileName"));
        food.setFoodImgPath(map.get("imgRelativePath"));
        int num = foodDao.insertFood(food);
        Food getLatestId=foodDao.selectLatestId();
        food.setFid(getLatestId.getFid());
        if(num == 0) {
            throw new RuntimeException("插入菜品失败");
        }
        num = foodDao.insertFoodType(food);
        if(num == 0) {
            throw new RuntimeException("插入菜品类别失败");
        }
        return num;
    }

}
