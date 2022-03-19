package com.RH.service;


import com.RH.db.dao.UserDao;
import com.RH.db.pojo.Food;
import com.RH.db.pojo.User;
import com.RH.db.pojo.User_Authority;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserServiceI{

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> selectAllUserByLimits() {
        return userDao.selectAllUserByLimits();
    }

    @Override
    public int deleteUserById(String uid) {
        if (uid.equals("")){
            throw new RuntimeException("无用户！");
        }
        int Intuid = Integer.parseInt(uid);
        int num=userDao.deleteUserById(Intuid);
        if(num==0){
            throw new RuntimeException("删除失败！");
        }

        num=userDao.deleteUserAById(Intuid);
        if(num==0){
            throw new RuntimeException("删除权限失败！");
        }
        return num;
    }

    @Override
    public int updateUserById(String jsonStr,String uid) {
        User user =JSON.parseObject(jsonStr,User.class);
        int Intuid = Integer.parseInt(uid);
        user.setUid(Intuid);
        int num=userDao.updateUserById(user);
        if(num==0){
            throw new RuntimeException("修改失败！");
        }
        return num;
    }

    @Override
    public int insertUser(String jsonStr) {
        User user =JSON.parseObject(jsonStr,User.class);
        user.setImgPath("images/defaultHeadimg.png");
        user.setHeadImg("defaultHeadimg.png");
        int num=userDao.insertUser(user);
        if(num==0){
            throw new RuntimeException("新增失败！");
        }

        User getLatestId=userDao.selectLatestId();

        User_Authority user_authority=new User_Authority();
        user_authority.setUid(getLatestId.getUid());
        user_authority.setAid(3);
        num=userDao.insertUserAuthority(user_authority);
        if(num==0){
            throw new RuntimeException("新增权限失败！");
        }
        return num;
    }

    @Override
    public int login(String userName, String userPsd, String captcha, HttpSession session) {
        if(userName.equals("")) {
            throw new RuntimeException("用户名不能为空！");
        }
        if(userPsd.equals("")) {
            throw new RuntimeException("密码不能为空！");
        }
        if(captcha.equals("")) {
            throw new RuntimeException("验证码不能为空！");
        }

        String cap= (String) session.getAttribute("captcha");

        if(!captcha.equalsIgnoreCase(cap)){
            throw new RuntimeException("验证码有误！");
        }

        User user = new User(userName,userPsd);
        user = userDao.login(user);
        if(user == null) {
            throw new RuntimeException("用户名或密码输入有误！");
        }else {
            session.setAttribute("user",user);
        }

        return user.getAuthorityType();
    }

    @Override
    public int updateUserPerson(String uid, String userName, String userPsd, MultipartFile ImgFile, HttpServletRequest request) {
        User user =new User();
        int Intuid = Integer.parseInt(uid);
        user.setUid(Intuid);
        user.setUserName(userName);
        user.setUserPsd(userPsd);
        Map<String,String> map = getimg(ImgFile,request);
        return updateUserPerson(user,map);
    }

    @Override
    public int insertUserregister(String userName, String userPsd, String sex) {
        if(userName.equals("")) {
            throw new RuntimeException("用户名不能为空！");
        }
        if(userPsd.equals("")) {
            throw new RuntimeException("密码不能为空！");
        }


        User user =new User();
        user.setUserName(userName);
        user.setUserPsd(userPsd);
        user.setSex(sex);
        user.setImgPath("images/defaultHeadimg.png");
        user.setHeadImg("defaultHeadimg.png");
        int num=userDao.insertUser(user);
        if(num==0){
            throw new RuntimeException("新增失败！");
        }

        User getLatestId=userDao.selectLatestId();

        User_Authority user_authority=new User_Authority();
        user_authority.setUid(getLatestId.getUid());
        user_authority.setAid(3);
        num=userDao.insertUserAuthority(user_authority);
        if(num==0){
            throw new RuntimeException("新增权限失败！");
        }
        return num;
    }

    private Map<String,String> getimg(MultipartFile ImgFile, HttpServletRequest request) {
        Map<String,String> map = new HashMap<String,String>();
        if(ImgFile!=null){
        //图片文件原名称
        String userImgName = ImgFile.getOriginalFilename();
        //得到图片的后缀名
        String imgFileExtension = userImgName.substring(userImgName.lastIndexOf("."));
        //生成新得图片名称: 因为上传的文件可能重名
        String newUserImgName = UUID.randomUUID().toString()+imgFileExtension;
        //获得图片要上传到服务器的路径
        String imgServerPath = request.getServletContext().getRealPath("/")+"images/"+newUserImgName;

        //创建图片目标目录
        File targetImgFile = new File(imgServerPath);
        //创建视频目标目录

        //向map中存值: 视频原名称、视频相对路径、图片相对路径
        try {
            ImgFile.transferTo(targetImgFile);//图片上传

            map.put("imgFileName", userImgName);

            //获得图片相对路径: 存入到数据库中
            String imgRelativePath = request.getServletContext().getContextPath()+"/images/"+newUserImgName;
            //获得视频相对路径: 存入到数据库中

            map.put("imgRelativePath", imgRelativePath);

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        }else {
            map.put("imgFileName", null);
            map.put("imgRelativePath", null);
        }
        return map;
    }

    private int updateUserPerson(User user, Map<String,String> map) {
        user.setHeadImg(map.get("imgFileName"));
        user.setImgPath(map.get("imgRelativePath"));

        int num=userDao.updateUserPerson(user);

        if(num==0){
            throw new RuntimeException("新增失败！");
        }
        return num;
    }
}
