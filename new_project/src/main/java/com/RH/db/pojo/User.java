package com.RH.db.pojo;

public class User {

    private String userName;
    private String userPsd;
    private String sex;
    private String imgPath;
    private int uid;
    private String headImg;

    private int authorityType;


    public User() {
    }

    public User(String userName, String userPsd) {
        this.userName = userName;
        this.userPsd = userPsd;
    }


    public int getAuthorityType() {
        return authorityType;
    }

    public void setAuthorityType(int authorityType) {
        this.authorityType = authorityType;
    }

    public String getUserPsd() {
        return userPsd;
    }

    public void setUserPsd(String userPsd) {
        this.userPsd = userPsd;
    }

    public String getHeadImg() {
        return headImg;
    }

    public void setHeadImg(String headImg) {
        this.headImg = headImg;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
}
