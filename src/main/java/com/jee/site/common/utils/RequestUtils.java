package com.jee.site.common.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

public class RequestUtils extends RequestContextUtils {

	
	public  static String  getString(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return  request.getParameter(key);
	}
	
	public  static String[]  getStrArray(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return  request.getParameterValues(key);
	}
	
	public  static int  getInt(String key){
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String value = request.getParameter(key);
		try{
			return Integer.parseInt(value);
		}catch(Exception e){}
		return 0;
	}
	
	public static HttpServletRequest getRequest(){
		return  ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
	}

}
