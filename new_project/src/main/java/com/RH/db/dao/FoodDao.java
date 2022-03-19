package com.RH.db.dao;

import com.RH.db.pojo.Food;
import com.RH.db.pojo.Food_Type;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodDao {

    public List<Food> selectAllFoodByLimits();

    public int deleteFoodById(int fid) ;

    public int deleteFoodTById(int fid) ;

    public List<Food_Type> selectFoodTyprByLimits();

    public int updateFood(Food food);

    public int updateFoodtype(Food food);

    public int insertFood(Food food);

    public int insertFoodType(Food food);

    public Food selectLatestId();


}
