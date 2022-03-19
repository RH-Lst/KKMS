package com.RH.service;

import com.RH.db.pojo.User;
import com.RH.utils.ResultMap;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public interface UserServiceI {

    public List<User> selectAllUserByLimits();

    public int deleteUserById(String uid);

    public int updateUserById(String jsonStr,String uid);

    public int insertUser(String jsonStr);

    public int login(String userName, String userPsd, String captcha, HttpSession session);

    public int updateUserPerson(String uid, String userName, String userPsd, MultipartFile ImgFile, HttpServletRequest request);

    public int insertUserregister(String userName,String userPsd,String sex);
}
