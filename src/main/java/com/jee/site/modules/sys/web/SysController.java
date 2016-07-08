/**
 * 
 */
package com.jee.site.modules.sys.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * 登录Controller
 * 
 * @version 2015-5-31
 */
@Controller
@RequestMapping("admin")
public class SysController{

	/**
	 * 登录成功，进入管理首页
	 */
	@RequestMapping()
	public String index(HttpServletRequest request, HttpServletResponse response,@RequestParam(value="langType", defaultValue="zh") String langType) {
		
		return "modules/sys/admin";
	}
	
}
