package com.RH.db.dao;

import com.RH.db.pojo.Food;
import com.RH.db.pojo.User;
import com.RH.db.pojo.User_Authority;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {

    public List<User> selectAllUserByLimits();

    public int deleteUserById(int uid) ;

    public int deleteUserAById(int uid) ;

    public int updateUserById(User user) ;

    public int insertUser(User user) ;

    public int insertUserAuthority(User_Authority user_authority) ;

    public User selectLatestId();

    public User login(User user);

    public int updateUserPerson(User user) ;


}