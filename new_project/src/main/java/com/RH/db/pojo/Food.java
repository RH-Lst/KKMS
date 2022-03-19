package com.RH.db.pojo;

public class Food {

    private int fid;
    private String foodName;
    private String foodDescription;
    private Double foodPrice;
    private String foodImg;
    private String foodImgPath;


    private int tid;
    private String foodType;

    private int ftid;


    public int getTid() {
        return tid;
    }

    public void setTid(int tid) {
        this.tid = tid;
    }

    public String getFoodType() {
        return foodType;
    }

    public void setFoodType(String foodType) {
        this.foodType = foodType;
    }

    public int getFtid() {
        return ftid;
    }

    public void setFtid(int ftid) {
        this.ftid = ftid;
    }

    public int getFid() {
        return fid;
    }

    public void setFid(int fid) {
        this.fid = fid;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public String getFoodDescription() {
        return foodDescription;
    }

    public void setFoodDescription(String foodDescription) {
        this.foodDescription = foodDescription;
    }

    public Double getFoodPrice() {
        return foodPrice;
    }

    public void setFoodPrice(Double foodPrice) {
        this.foodPrice = foodPrice;
    }

    public String getFoodImg() {
        return foodImg;
    }

    public void setFoodImg(String foodImg) {
        this.foodImg = foodImg;
    }

    public String getFoodImgPath() {
        return foodImgPath;
    }

    public void setFoodImgPath(String foodImgPath) {
        this.foodImgPath = foodImgPath;
    }
}
