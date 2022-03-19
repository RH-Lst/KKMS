package com.RH.controller;


import com.RH.db.pojo.User;
import com.RH.service.UserServiceI;
import com.RH.utils.ResultMap;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserServiceI userServiceI;
    @Autowired
    private ResultMap resultMap;


    @RequestMapping("/selectAllUserByLimits")
    @ResponseBody
    public ResultMap selectAllUserByLimits(int page,int limit){
        try{
            PageHelper.startPage(page, limit);//开启分页
            List<User> list=userServiceI.selectAllUserByLimits();
            PageInfo<User> pageInfo=new PageInfo<User>(list);
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


    @RequestMapping("/deleteUserById")
    @ResponseBody
    public ResultMap deleteUserById(String uid){
        try{
            userServiceI.deleteUserById(uid);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }


    @RequestMapping("/updateUserById")
    @ResponseBody
    public ResultMap updateUserById(String jsonStr,String uid){
        try{
            userServiceI.updateUserById(jsonStr,uid);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

    @RequestMapping("/insertUser")
    @ResponseBody
    public ResultMap insertUser(String jsonStr){
        try{
            userServiceI.insertUser(jsonStr);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }


    @RequestMapping("/login")
    @ResponseBody
    public ResultMap login(String userName, String userPsd, String captcha , HttpSession session) {
        try {
            int authority=userServiceI.login(userName,userPsd,captcha,session);
            resultMap.setStatus(true);
            resultMap.setAuthority(authority);
        } catch (Exception e) {
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

    @RequestMapping("/signout")
    public String signout(HttpSession session) {
        session.invalidate();
        return "login";
    }


    @RequestMapping("/updateUserPerson")
    public void updateUserPerson(String uid, String userName, String userPsd, MultipartFile ImgFile, HttpSession session, HttpServletRequest request){
        session.invalidate();
        try{
            if(ImgFile.getSize()==0){
                ImgFile=null;
            }
            userServiceI.updateUserPerson(uid,userName,userPsd,ImgFile,request);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }

    }

    @RequestMapping("/register")
    @ResponseBody
    public ResultMap insertUserregister(String userName,String userPsd,String sex){
        try{
            userServiceI.insertUserregister(userName,userPsd,sex);
            resultMap.setStatus(true);
        }catch (Exception e){
            resultMap.setStatus(false);
            resultMap.setMessage(e.getMessage());
        }
        return resultMap;
    }

}
