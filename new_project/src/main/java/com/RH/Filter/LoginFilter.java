package com.RH.Filter;

import com.RH.db.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req= (HttpServletRequest) servletRequest;
        HttpServletResponse resp= (HttpServletResponse) servletResponse;
        HttpSession session=req.getSession();
        User user= (User) session.getAttribute("user");
        if(user == null){
            filterChain.doFilter(req, resp);
        }else if(user!=null && user.getAuthorityType()==0){
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } else if(user!=null && user.getAuthorityType()==1){
            req.getRequestDispatcher("index1.jsp").forward(req, resp);
        }else if(user!=null && user.getAuthorityType()==2){
            req.getRequestDispatcher("index2.jsp").forward(req, resp);
        }

    }

    @Override
    public void destroy() {

    }
}
